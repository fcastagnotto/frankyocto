### Franke image base

SUMMARY = "Frank's first try of image"

IMAGE_FEATURES += "splash  allow-empty-password \
                    allow-root-login bash-completion-pkgs \
                    ssh-server-openssh"

IMAGE_INSTALL_append +=  "nano "
IMAGE_INSTALL_remove += " packagegroup-base-extended"

LICENSE = "MIT"

inherit core-image
