#!/usr/bin/env bash

set -e
set -o pipefail

IMAGE=$1
FILENAME=${2:-version}

if [[ -z ${IMAGE} ]] ; then
    echo "Usage: $(basename "$0") image [filename]"
    exit 1
fi

VERSION=$(echo ${IMAGE} | awk -F: '{print $2}')

anybadge --overwrite --label=version --value=${VERSION:-latest} --file ${FILENAME}.svg
