#!/bin/bash

echo "setup yocto.."
ln -s /yocto/sources/meta-frank/oe-init-build-frank /yocto/sources/poky/
cd /yocto/sources/poky/
source oe-init-build-frank ../../build

echo "starting build.."

MACHINE=raspberrypi DISTRO=milleniumfalcon bitbake frank-image-base