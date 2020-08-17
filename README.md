# Frank Yocto

Build of Yocto with creation of a new meta-layer with all the configurations and parts wanted for a well-done yocto system.

F.Castagnotto [mailto:fcastagnotto@linux.com]

## Clone

This repository use various other public repository as sources. <br>
For that, the required repos are configured as submodules. <br>
To correctly clone the repo and all the other sources, use the following command:
```shell
$ git clone --recursive git@github.com:fcastagnotto/frankyocto.git
```
and in case of download errors of submodules, use the command:
```shell
$ git submodule update --init --recursive
```

## Setup

### environment setup
The "*docker*" folder contains the **dockerbuild.sh** script that automatically create the docker image with all the components required to setup the build environment, based on the **Dockerfile** configuration file. <br>
Simply launch:
```shell
$ ./dockerbuild.sh
```

### environment start
The "*docker*" folder contains the **dockerrun.sh** script that start the container from the previously created image. <br>
Simply launch:
```shell
$ ./dockerrun.sh
```


## Build

To launch the yocto build:
1. launch the container
2. setup the yocto build environment
```shell
$ ln -s /yocto/sources/meta-frank/oe-init-build-frank /yocto/sources/poky/
$ cd /yocto/sources/poky/
$ source oe-init-build-frank ../../build
```
3. start the yocto build with the command:
```shell
$ bitbake frank-image-base
```
<!--$ bitbake linux-yocto-custom, why not? -->

### Image frank-image-base
At the project starts, that base image simply contains:
- few starting tools to login and starts
- **Nano** editor
- **Boinc client**, to share the computation resources of the RPI for volunteer computing and grid computing

### Burn SD Image
At the end of build, an image file can be found into the folder **build/tmp/deploy/images/raspberrypi/** with name **frank-image-base-raspberrypi.rpi-sdimg**. <br>
To write the image on an SD card can be done with the DD command:
```shell
$ dd if=frank-image-base-raspberrypi.rpi-sdimg of=/dev/sda bs=10M status=progress && sync
```

------------------------------------------------------------------------------------------

[2020.08.17] First understood of purpose of project (xD), Readme creation and recap of older
build attempts



## References
[Boinc project](https://boinc.berkeley.edu)<br>
[World Community Grid projects](https://www.worldcommunitygrid.org/research/viewAllProjects.do)
