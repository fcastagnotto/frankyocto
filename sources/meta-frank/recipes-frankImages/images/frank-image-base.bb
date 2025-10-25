LICENSE = "MIT"

require recipes-core/images/core-image-base.bb
### Franke image base

SUMMARY = "Frank first try of image"

IMAGE_FEATURES += "splash  allow-empty-password \
                    allow-root-login bash-completion-pkgs \
                    ssh-server-openssh"

IMAGE_INSTALL:append =  " nano "
IMAGE_INSTALL:remove = "packagegroup-base-extended"
