#!/bin/bash

# if [[ -d ./build ]]; then
#     rm -f build/conf/{local.conf,bblayers.conf}
# fi
TEMPLATECONF=/yocto/sources/meta-frank/conf/templates/conf2 source sources/poky/oe-init-build-env build

echo "starting build.."

MACHINE=raspberrypi DISTRO=milleniumfalcon bitbake frank-image-base
