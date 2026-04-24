inherit kernel

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${THISDIR}/linux-master:"

# Override SRC_URI in a copy of this recipe to point at a different source
# tree if you do not want to build from Linus' tree.
SRC_URI += "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git;protocol=git;branch=master \
            file://defconfig \
            file://netfilter.cfg"

KERNEL_CONFIG_FRAGMENTS += "netfilter.cfg"
KCONFIG_MODE = "--alldefconfig"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"


LINUX_VERSION ?= "7.0"
LINUX_VERSION_EXTENSION:append = "-frank-embedded"


S = "${WORKDIR}/git"
# Modify SRCREV to a different commit hash in a copy of this recipe to
# build a different release of the Linux kernel.
# tag: v4.2 64291f7db5bd8150a74ad2036f1037e6a0428df2
SRCREV="3131ff5a117498bb4b9db3a238bb311cbf8383ce"

PV = "${LINUX_VERSION}+git${SRCPV}"

# Override COMPATIBLE_MACHINE to include your machine in a copy of this recipe
# file. Leaving it empty here ensures an early explicit build failure.
COMPATIBLE_MACHINE = "^raspberrypi.*"
