# FrankYocto

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Yocto Version](https://img.shields.io/badge/Yocto-Scarthgap-green.svg)](https://www.yoctoproject.org/)
[![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi-red.svg)](https://www.raspberrypi.org/)

> A production-ready Yocto build system with custom meta-layer featuring RAUC-based A/B updates, BOINC integration, and complete embedded Linux system configuration for Raspberry Pi.

## Table of Contents

- [Getting Started](#getting-started)
    - [About](#about)
    - [Features](#features)
    - [Hardware Support](#hardware-support)
    - [Prerequisites](#prerequisites)

- [Installation & Usage](#installation--usage)
    - [Quick Start](#quick-start)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Update System](#update-system)

- [Development](#development)
    - [Project Structure](#project-structure)
    - [Troubleshooting](#troubleshooting)
    - [Contributing](#contributing)

- [Additional Information](#additional-information)
    - [License](#license)
    - [References](#references)
    - [Changelog](#changelog)

---

## Getting Started

### About

FrankYocto is a complete Yocto-based build system designed for creating robust, updatable embedded Linux images for Raspberry Pi. It includes a custom meta-layer (`meta-frank`) with all necessary configurations for production environments, featuring over-the-air (OTA) updates via RAUC, distributed computing capabilities with BOINC, and security-hardened SSH access.

**Author**: F. Castagnotto ([fcastagnotto@linux.com](mailto:fcastagnotto@linux.com))

### Features

- **A/B Update System**: RAUC-based atomic updates with rollback capability
- **BOINC Client**: Share computing resources for volunteer and grid computing projects
- **Secure Access**: OpenSSH with public key authentication
- **Minimal Base Image**: Optimized for embedded systems
- **Dockerized Build Environment**: Reproducible builds with Ubuntu 24.04
- **Development Tools**: Includes Nano editor and essential utilities
- **Performance**: tmpfs mount for `/tmp` directory
- **Network**: Static IP configuration support

### Hardware Support

Currently supported platforms:

- **Raspberry Pi (original) - Model B, Model A, Model B+, Model A+**
- **Raspberry Pi 3**

> **Note**: The system requires an SD card of at least 8GB for proper A/B partition layout.

### Prerequisites

Before you begin, ensure you have the following installed:

- **Git** (version 2.x or higher)
- **Docker** (version 20.x or higher)
- **Docker Compose** (optional, for advanced setups)
- **Disk Space**: At least 100GB free space for builds
- **RAM**: Minimum 8GB (16GB recommended)
- **SD Card**: 8GB or larger for target device

#### Knowledge Prerequisites

- Basic understanding of Yocto Project
- Familiarity with Docker containers
- Basic Linux command line skills
- Understanding of embedded Linux systems (helpful but not required)

---

## Installation & Usage

### Quick Start

#### via Podman

```bash
# 1. Clone the repository with all submodules
git clone --recursive https://github.com/fcastagnotto/frankyocto.git
cd frankyocto

# 1.b clean and align the submodules
./clean_subm.sh

# 2. Build and start Containers environment
./podman/podmanrun.sh

# 3. Inside the container, run the build
./build.sh
```

#### via Docker

```bash
# 1. Clone the repository with all submodules
git clone --recursive https://github.com/fcastagnotto/frankyocto.git
cd frankyocto

# 1.b clean and align the submodules
./clean_subm.sh

# 2. Build and start Containers environment
cd docker/
./dockerbuild.sh

# 3. Start the Docker container
cd ..
docker/dockerrun.sh

# 4. Inside the container, run the build
./build.sh
```


### Installation

#### 1. Clone Repository

This repository uses Git submodules for Yocto layers. Clone with submodules:

```bash
git clone --recursive https://github.com/fcastagnotto/frankyocto.git
cd frankyocto
```

If you've already cloned without `--recursive`, initialize submodules:

```bash
git submodule update --init --remote --recursive
```

In some cases the alignment of submodules it's not well done by the git submodule command. For these cases, I created the script *clean_subm.sh*, just launch it and let the magic fix appens:

```bash
./clean_subm.sh
```

#### 2. Docker Environment Setup

The `docker` folder contains scripts to create a reproducible build environment:

```bash
cd docker
./dockerbuild.sh
```

This creates a Docker image based on Ubuntu 24.04 with all Yocto dependencies.

#### 3. Start Build Container

Launch the container with your working directory mounted:

```bash
./dockerrun.sh
```

You'll be dropped into a shell inside the container with all tools ready.

### Usage

#### Building the Image

From inside the Docker container:

```bash
cd /yocto
./build.sh
```

The `build.sh` script performs the following:

1. Sets up the Yocto environment using `meta-frank` templates
2. Builds the `frank-image-base` image
3. Creates the RAUC update bundle

#### Image Components

**frank-image-base** includes:

| Component | Description |
|-----------|-------------|
| Base System | Login utilities, systemd, essential tools |
| nano | Lightweight text editor |
| dhcpcd | DHCP client daemon for network configuration |
| openvpn | VPN client for secure connections |
| boinc-client | Distributed computing client |
| rauc | Robust Auto-Update Controller |
| openssh | Secure remote access with public key auth |
| e2fsprogs | ext2/ext3/ext4 filesystem utilities (tune2fs, resize2fs) |
| python3 | Python interpreter with pip package manager |
| speedtest-cli | Command-line interface for testing internet bandwidth |
| network | Static ethernet configuration (eth0) |
| /tmp | tmpfs for `/tmp` |


**frank-image-python3** extends frank-image-base with additional Python libraries:

| Additional Component | Description |
|---------------------|-------------|
| python3-netifaces | Network interface information |
| python3-blinker | Fast object-to-object and broadcast signaling |
| python3-click | Command-line interface creation toolkit |
| python3-colorama | Cross-platform colored terminal text |
| python3-flask | Lightweight WSGI web application framework |
| python3-itsdangerous | Data signing library |
| python3-jinja2 | Template engine for Python |
| python3-markupsafe | XML/HTML/XHTML markup safe string implementation |
| python3-packaging | Core utilities for Python packages |
| python3-werkzeug | WSGI utility library for Python |

#### Output Files

After successful build, find your images at:

```
build/tmp-glibc/deploy/images/raspberrypi/
build/tmp-glibc/deploy/images/raspberrypi3-64/
```

- **SD Card Image**: `frank-image-base-raspberrypi.rootfs.wic.bz2`
- **Update Bundle**: `frank-image-bundle-raspberrypi.raucb`

#### Writing to SD Card

On your host system (not inside Docker):

```bash
# Decompress and write to SD card (replace /dev/sdX with your SD card device)
bunzip2 -c frank-image-base-raspberrypi.rootfs.wic.bz2 | \
    sudo dd of=/dev/sdX bs=4M conv=fsync status=progress
sync
```

⚠️ **Warning**: Double-check your device name (`/dev/sdX`). Using the wrong device will destroy data!

#### First Boot

1. Insert SD card into Raspberry Pi
2. Connect network cable (if using static IP)
3. Power on the device
4. SSH access will be available with your configured public key

Default connection (adjust to your configuration):

```bash
ssh root@<raspberry-pi-ip>
```

### Update System

#### RAUC Updates

FrankYocto uses RAUC for safe, atomic updates with A/B partitioning:

- **Partition A**: Primary system
- **Partition B**: Backup/update system
- Automatic rollback on failed boot

### Deploying Updates

#### Via QBEE (Recommended for Fleet Management)

Upload `frank-image-bundle-raspberrypi.raucb` to your QBEE profile and deploy to devices.

#### Manual Update

Copy the bundle to the device:

```bash
scp frank-image-bundle-raspberrypi.raucb root@<raspberry-pi-ip>:/data/
```

Install on the device:

```bash
ssh root@<raspberry-pi-ip>
rauc install /data/frank-image-bundle-raspberrypi.raucb
reboot
```

### Checking Update Status

```bash
rauc status
```

## Project Structure

```
frankyocto/
├── docker/                  # Docker build environment
│   ├── Dockerfile          # Container definition
│   ├── dockerbuild.sh      # Build script
│   └── dockerrun.sh        # Run script
├── sources/                # Yocto layers (submodules)
│   ├── poky/              # Core Yocto
│   ├── meta-openembedded/ # Additional layers
│   ├── meta-raspberrypi/  # BSP layer
│   ├── meta-rauc/         # RAUC layer
│   ├── meta-rauc-community/ # RAUC community recipes
│   └── meta-frank/        # Custom layer (★)
├── build/                 # Build output (generated)
├── build.sh              # Main build script
└── README.md             # This file
```

**★ meta-frank** contains all custom recipes, configurations, and machine definitions.

### Troubleshooting

#### Submodule Errors

**Problem**: Submodules fail to clone

**Solution**:
```bash
git submodule update --init --remote --recursive
```

#### Docker Build Fails

**Problem**: Docker image build fails due to network issues

**Solution**:
```bash
# Retry with no cache
cd docker
docker build --no-cache -t yocto-build .
```

#### Out of Disk Space

**Problem**: Build fails with "No space left on device"

**Solution**:
```bash
# Clean up old builds
cd build
rm -rf tmp-glibc/work/*
# Or use Yocto's cleanup
bitbake -c cleanall <recipe-name>
```

#### SD Card Not Booting

**Problem**: Raspberry Pi doesn't boot from SD card

**Checklist**:
- Verify SD card is at least 8GB
- Ensure complete write: check `dd` completed without errors
- Try a different SD card (some cards are unreliable)
- Check power supply (5V/3A recommended for RPi 4)

#### SSH Connection Refused

**Problem**: Cannot SSH to the device

**Solution**:
- Verify network connection and IP address
- Check public key is correctly configured in meta-frank
- Ensure SSH service is running: `systemctl status sshd`

#### Getting Help

If you encounter issues:

1. Check the [Yocto Project Documentation](https://docs.yoctoproject.org/)
2. Review build logs in `build/tmp-glibc/log/`
3. Open an issue on GitHub with:
   - Error messages
   - Build configuration
   - Steps to reproduce

---

## Additional Information

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

> **Note**: Individual Yocto layers and components may have different licenses. Check each submodule for specific licensing information.

### References

[Yocto Project Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html) \
[Yocto Project Documentation](https://docs.yoctoproject.org/) \
[RAUC - Safe and Secure OTA Updates](https://rauc.io/) \
[RAUC Documentation](https://rauc.readthedocs.io/) \
[BOINC Project](https://boinc.berkeley.edu) \
[World Community Grid Projects](https://www.worldcommunitygrid.org/research/viewAllProjects.do) \
[Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/) \
[meta-raspberrypi Layer](https://git.yoctoproject.org/meta-raspberrypi/)

### Changelog

#### 2026.06.18
- ✅ Fix submodule alignment on clean clone of repo
- 🚫 add management of PocketBeagle2
- 🚫 rewrite of README to be more simple
- 🚫 add management ssh keys guide
- 🚫 add procedure for RAUC key


#### 2025.10.31
- ✅ RAUC integration complete and working with QBEE
- ✅ Certificate-based update authentication implemented

#### 2025.10.30
- ✅ First successful build with RAUC
- ✅ System running on Raspberry Pi hardware

#### 2025.10.27
- ➕ Added RAUC layer and RAUC community layer

#### 2025.10.26
- 🧹 Major cleanup of repository tree
- ⬆️ Updated to Yocto Scarthgap release
- ⬆️ Dockerfile updated to Ubuntu 24.04
- ➖ Removed sw-update submodule (replaced by RAUC)

#### 2020.08.17
- 🎉 Initial project creation
- 🎯 First working base Yocto build

---

**Made with ❤️ for the embedded Linux community**

*For questions or support, contact: [fcastagnotto@linux.com](mailto:fcastagnotto@linux.com)*
