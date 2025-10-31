FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append := " file://frank.cert.pem \
					file://system.conf"

S = "${WORKDIR}"

RAUC_KEYRING_FILE = "frank.cert.pem"
RAUC_KEYRING_URI := "file://${RAUC_KEYRING_FILE}"

do_install:prepend() {
	sed -i "s/@@MACHINE@@/${MACHINE}/g" ${WORKDIR}/system.conf
}

do_install:append() {
	install -d ${D}/etc/rauc
	install -m 0644 ${WORKDIR}/system.conf ${D}/etc/rauc/system.conf
}