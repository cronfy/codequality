# Template for adding code quality tools to a Gitlab project

## Installation for a gitlab project

1. Clone this repository.
2. Change directory to `image/`
3. Build `codequality` image and push it into your gitlab project's registry, give it `codequality` name, for example:
    ```bash
    ./build-and-push-to-registry.sh gitlab.com/mygroup/myproject/codequality
    ```
4. Put tools' configuration files (see `examples/`) into a project repository root, set them up.
5. Add code quality jobs into `.gitlab-ci.yml` (see `examples/`).

Done!

## Run locally

Prerequisites: 

1. Project already has code quality tools configuration files.
2. Docker is installed.

Steps to run code quality check locally:

1. Clone this repository.
2. Go to a directory where you project resists.
3. Run `/path/to/codequality/cq <tool>`, for example: `~/projects/tools/codequality/cq phpcs`

