# Configure additional / custom code quality rules

## For phpcs - third party rule

1. Create `tools/codequality` directory in the project.
2. Install additional phpcs rules as specified in rules' documentation (for example, using composer) to this directory.
3. Configure rules in `phpcs.xml`.
4. Add `composer install` for `tools/codequality` to `.gitlab-ci.yml` prior to `phpcs` run. 

Done!

See `tools/codequality` contents example [here](phpcs).

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

## For phpstan - custom rule

1. Create directory in the project repository for custom phpstan rules, for example `tools/codequality/phpstan`.
2. Add your rules' files there.
3. Create a `bootstrap.php` file containing `require()` for all your rule files or autoload them in other way.
4. Add bootstrap file argument to `phpstan` invocation: `phpstan analyse -a tools/codequality/phpstan/bootstrap.php ...`

Done!

See examples [here](phpstan).

`.gitlab-ci.yml` addition:

```yaml
.phpcs-codequality:
  script:
    # ... before phpstan ... 
    # phpstan
    - phpstan --error-format=gitlab analyse -a tools/codequality/phpstan/bootstrap.php > phpstan-codequality.json || true
    #                             add this: ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
    # ... after phstan ...
```

