# Frank Yocto

Build of Yocto with creation of a new meta-layer with all the configurations and parts wanted for a well-done yocto system.

F.Castagnotto [mailto:fcastagnotto@linux.com]

## Setup

### Environment setup
The "*docker*" folder contains the **dockerbuild.sh** script that automatically create the docker image with all the components required to setup the build environment, based on the **Dockerfile** configuration file.
So, simply launch:
```shell
$ ./dockerbuild.sh
```

### Build
1. launch the docker daemon
2. setup the environment
3. run the **dockerrun.sh** script
4. start the yocto build with the command:

```shell
$ bitbake frank-image-base
```
<!--$ bitbake linux-yocto-custom, why not? -->

## Frank-Image-Base
At the project starts, that base image simply contains:
- few starting tools to login and starts
- **Nano** editor
- **Boinc client**, to share the computation resources of the RPI for volunteer computing and grid computing

## Burn SD Image
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
