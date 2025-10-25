#!/bin/bash

TEMPLATECONF=/yocto/sources/meta-frank/conf/templates/conf1 source sources/poky/oe-init-build-env build

echo "starting build.."

MACHINE=raspberrypi DISTRO=milleniumfalcon bitbake frank-image-base