LICENSE = "MIT"

require recipes-core/images/core-image-base.bb
### Franke image base

SUMMARY = "Frank first try of image"
IMAGE_FSTYPES="tar.bz2 ext4 wic.bz2 wic.bmap"

IMAGE_FEATURES += "splash  allow-empty-password \
                    allow-root-login bash-completion-pkgs \
                    ssh-server-openssh"

IMAGE_INSTALL:remove = "packagegroup-base-extended \
                        pango rust-llvm rust-llvm-native \
                        python3-pyyaml-native wxwidgets"

IMAGE_INSTALL:append =  " nano dhcpcd openvpn \
                         rauc python3-speedtest-cli \
                         e2fsprogs \
                         e2fsprogs-tune2fs e2fsprogs-resize2fs \
                         static-eth0 \
                         boinc-client openssh \
                         python3 python3-pip \
                         "