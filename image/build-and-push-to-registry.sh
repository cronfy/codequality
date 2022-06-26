#!/usr/bin/env bash

set -eu -o pipefail

function syntax() {
	echo "Buld image and push it to the project's Container registry"
	echo
	echo "Usage: `basename $0` <registry_image_url>"
	echo "Example: `basename $0` gitlab.mycompany.com/mygroup/myproject/codequality"
}

REGISTRY_URL="${1:-}"

[ -z "$REGISTRY_URL" ] && { syntax >&2; exit 1; }

cd `dirname $0`

docker build -t $REGISTRY_URL .
docker push $REGISTRY_URL

