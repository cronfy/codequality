# Configure additional / custom code quality rules

## For phpcs

1. Add `tools/codequality` directory to the project.
2. Install additional phpcs rules as specified in rules' documentation (for example, using composer).
3. Configure rules in `phpcs.xml`.
4. Add `composer install` for `tools/codequality` to `.gitlab-ci.yml` prior to `phpcs` run. 

Done!

See `tools/codequality` contents example [here](tools-codequality).

Additional rule `phpcs.xml` configuration example, along with limiting paths where this rule should be applied.

```xml
<ruleset name="This project standard">

    <config name="installed_paths" value="tools/codequality/vendor/slevomat/coding-standard"/>
    
    <rule ref="tools/codequality/vendor/slevomat/coding-standard/SlevomatCodingStandard/Sniffs/TypeHints/DeclareStrictTypesSniff.php">
        <exclude-pattern>/app/lib/ThirdParty</exclude-pattern>
        <properties>
            <property name="spacesCountAroundEqualsSign" value="0"/>
        </properties>
    </rule>

</ruleset>
```

`.gitlab-ci.yml` addition:

```yaml
.phpcs-codequality:
  # cache dependency libraries
  cache:
    - key:
        files:
          - tools/codequality/composer.lock
      paths:
        - tools/codequality/vendor
  
  script:
    # install dependencies
    - cd tools/codequality && composer install && cd "$CI_PROJECT_DIR"
    # ... code quality tools execution ... 
```

