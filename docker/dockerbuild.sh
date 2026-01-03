#!/bin/bash
#
# v1.0

cd "$(dirname "$0")" || exit 1

docker build . -t dockeryp:24.04 --network=host
docker image prune -f
