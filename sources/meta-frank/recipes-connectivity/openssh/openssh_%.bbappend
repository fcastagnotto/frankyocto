FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://authorized_keys"

do_install:append:raspberrypi (){
    install -d ${D}/home/root/.ssh
    install -m 600 ${WORKDIR}/authorized_keys ${D}/home/root/.ssh/authorized_keys
}

FILES:${PN} += "${ROOT_HOME}/.ssh/authorized_keys"