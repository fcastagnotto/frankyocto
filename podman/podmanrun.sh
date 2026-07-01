#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

podman compose \
    -f "${SCRIPT_DIR}/compose.yaml" \
    run --rm yocto bash 
