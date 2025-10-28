#!/bin/bash

TEMPLATECONF=/yocto/sources/meta-frank/conf/templates/conf2 source sources/poky/oe-init-build-env build

echo "starting build.."

MACHINE=raspberrypi DISTRO=milleniumfalcon bitbake frank-image-base
