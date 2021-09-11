#!/usr/bin/env bash

set -ex
set -o pipefail

IMAGE=$1
FILENAME=${2:-size}
COLOUR=${3-#066da5}


if [[ -z ${IMAGE} ]] ; then
    echo "Usage: $(basename "$0") image [filename] [colour]"
    exit 1
fi

LAYERS=$(docker inspect -f "{{ len .RootFS.Layers }}" ${IMAGE})
SIZE=$(docker save ${IMAGE} | gzip | wc -c  | numfmt --to=iec-i --suffix B)

echo "Layers: ${LAYERS} Size: ${SIZE}"

anybadge --overwrite --label "${SIZE}" --value "${LAYERS}" --suffix " layers" --color "${COLOUR}" --file ${FILENAME}.svg
