#!/bin/bash

#---------------------------------------------------------------------------------
# Description:      Build for Frank images
# Version:          1.8
# Date:             2026-06-24
# Author:           Francesco Castagnotto <fcastagnotto@linux.com>
#---------------------------------------------------------------------------------

TEMPLATECONF=/yocto/sources/meta-frank/conf/templates/conf4 source sources/poky/oe-init-build-env build

MACHINE=""
IMAGE=""
BUNDLE=""
SDCARD_SIZE=8g

echo "Select the MACHINE:
    1- raspberrypi
    2- raspberrypi3-64
    3- pocketbeagle2 "
read -n 1 -r choice
echo

case "$choice" in
    1)
        MACHINE="raspberrypi"
        ;;
    2)
        MACHINE="raspberrypi3-64"
        ;;
    3)
        MACHINE="pocketbeagle2"
        ;;
    *)
        MACHINE="raspberrypi"
        ;;
esac


if [ "$MACHINE" = "raspberrypi3-64"  ];then
    echo "Select the size of SDcard:
        1- 8 GB
        2- 16 GB 
        3- 32 GB"
    read -n 1 -r choice
    echo

    case "$choice" in
        1)  SDCARD_SIZE="8g" ;;
        2)  SDCARD_SIZE="16g" ;;
        3)  SDCARD_SIZE="32g" ;;
        *)  SDCARD_SIZE="8g"  ;;
    esac

    cat > conf/auto.conf <<EOF
SD_LAYOUT = "sd${SDCARD_SIZE}"
require \${TOPDIR}/../sources/meta-frank/conf/sdlayout/\${SD_LAYOUT}.conf
EOF

else
    rm conf/auto.conf
fi


echo "Select the IMAGE:
    1- frank-image-base
    2- frank-image-python3"
read -n 1 -r choice
echo

case "$choice" in
    1)
        IMAGE="frank-image-base"
        BUNDLE="frank-bundle-base"
        ;;
    2)
        IMAGE="frank-image-python3"
        BUNDLE="frank-bundle-python3"
        ;;
    *)
        IMAGE="frank-image-base"
        BUNDLE="frank-bundle-base"
        ;;
esac

echo -n "Create RAUC bundle? (Y/n) "
read -n 1 -r choice
echo

case "$choice" in
    N|n)
        bundle="no"
        ;;
    *)
        bundle="yes"
        ;;
esac

echo "starting build.."

echo "MACHINE=${MACHINE} DISTRO=milleniumfalcon bitbake ${IMAGE}"
MACHINE=${MACHINE} DISTRO=milleniumfalcon bitbake ${IMAGE}

if [[ "$bundle" == "yes" ]];then
    MACHINE=${MACHINE} DISTRO=milleniumfalcon bitbake ${BUNDLE}
fi

echo ""
echo "Build done of MACHINE=${MACHINE} DISTRO=milleniumfalcon bitbake ${IMAGE}"
if [ "$MACHINE" = "raspberrypi3-64"  ];then
    echo "SDcard size is ${SDCARD_SIZE}"
fi