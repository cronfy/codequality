#!/usr/bin/env bash

[ -z "$1" ] && {
	echo "Syntax: `basename $0` \$CI_PROJECT_DIR" >&2
	exit 1
}

CI_PROJECT_DIR="$1"

cd "`dirname $0`"

sed 's=\\/=/=g' | sed "s=$CI_PROJECT_DIR/==g" | jq -f phpcs-json-to-codequality.jq
