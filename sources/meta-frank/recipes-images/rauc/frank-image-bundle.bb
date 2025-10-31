SUMMARY = "RAUC bundle for frank-image-base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit bundle
RAUC_BUNDLE_SLOTS = "rootfs"
RAUC_SLOT_rootfs  = "frank-image-base"
RAUC_BUNDLE_FORMAT = "verity"

RAUC_IMAGE_FSTYPE = "ext4"

# ---- COMPATIBILITY/METADATA -------------------------------------------
PV = "1.0"
RAUC_BUNDLE_VERSION = "${PV}"
RAUC_BUNDLE_COMPATIBLE  = "${MACHINE}"
RAUC_BUNDLE_DESCRIPTION = "Update bundle of frank-image-base for ${MACHINE}"

RAUC_KEY_FILE  = "${THISDIR}/files/frank.key.pem"
RAUC_CERT_FILE = "${THISDIR}/files/frank.cert.pem"