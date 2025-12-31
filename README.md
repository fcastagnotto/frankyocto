# Frank Yocto

Yocto build that includes a custom meta-layer with all the configurations and components needed for a complete, well-structured embedded Linux system.

F.Castagnotto [mailto:fcastagnotto@linux.com]

## Clone

This repository uses several public repositories as sources. <br>
Therefore, the required repositories are configured as Git submodules. <br>
To correctly clone the repository and all the other sources, use the following command:
```shell
git clone --recursive git@github.com:fcastagnotto/frankyocto.git
```
If submodule download errors occur, use the following command:
```shell
cd frankyocto
git submodule update --init --remote --recursive
```

## Setup

### Environment Setup
The *docker* folder contains the **dockerbuild.sh** script, which automatically creates the Docker image with all the components required to set up the build environment, based on the **Dockerfile**. <br>
Simply run:
```shell
cd docker
./dockerbuild.sh
```

### Environment Start
The "*docker*" folder contains the **dockerrun.sh** script, which starts the container from the previously created image. <br>
Simply run:
```shell
./dockerrun.sh
```


## Build

To start the Yocto build, simply run the **build.sh** script. It will:
1. Set up the environment using the templates provided in meta-frank
2. Launch the creation of the image of **frank-image-base**
3. Create the RAUC update bundle 

### Image frank-image-base
The base image includes:
- a few basic tools for login and startup
- **Nano** editor
- **BOINC client**, to share the Raspberry Pi’s computing resources for volunteer and grid computing
- **RAUC** client
- **RAUC configuration** including the partition map required for A/B update
- **OpenSSH** with public key configuration
- **Static IP configuration**
- **/tmp** mounted as tmpfs

### Burn SD Image

The final SD-card image can be found at
**build/tmp-glibc/deploy/images/raspberrypi**.

The name of the file will be **frank-image-base-raspberrypi.rootfs.wic.bz2**
and can be written to an SD card using the dd command:
```shell
$ bunzip2 -c frank-image-base-raspberrypi.rootfs.wic.bz2 | sudo dd of=/dev/sdX bs=4M conv=fsync status=progress
$ sync
```

### Bundle Image for RAUC

The second build step creates the bundle to be used for updates via RAUC. <br>
The file will be named **frank-image-bundle-raspberrypi.raucb** and can be easily loaded on a QBEE profile to launch the update, or alternatively copied to the Raspberry Pi’s storage and then used for system updates via RAUC.

## References
[Yocto Project Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)<br>
[RAUC - Safe and secure OTA updates for Embedded Linux](https://rauc.io/)<br>
[BOINC project](https://boinc.berkeley.edu)<br>
[World Community Grid Projects](https://www.worldcommunitygrid.org/research/viewAllProjects.do)

<br>

---

- **2025.10.31** RAUC working with QBEE and RAUC certificates  
- **2025.10.30** Built with RAUC, running on Raspberry Pi 
- **2025.10.27** Added RAUC layer and RAUC community layer      
- **2025.10.26** Cleaned tree, updated to Yocto Scarthgap, updated Dockerfile to Ubuntu 24.04, removed submodule sw-update  
- **2020.08.17** First understanding of the project’s purpose 😄, creation of the base Yocto


