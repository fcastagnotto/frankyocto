### Franke image base

SUMMARY = "Frank's first try of image"

IMAGE_FEATURES += "splash  allow-empty-password allow-root-login bash-completion-pkgs ssh-server-openssh"

IMAGE_INSTALL_append +=  "boinc-client \
                        nano"

#PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-custom"

LICENSE = "MIT"

inherit core-image
