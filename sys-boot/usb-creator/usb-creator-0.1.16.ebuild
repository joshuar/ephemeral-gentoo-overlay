# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

DESCRIPTION="Simple utility designed to make bootable USB desktop images from CD images. "
HOMEPAGE="https://launchpad.net/usb-creator"
SRC_URI="mirror://ubuntu/pool/main/u/usb-creator/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~s390 ~x86"
IUSE=""

DEPEND="dev-python/python-distutils-extra"
RDEPEND="x11-libs/gksu
		 sys-fs/mtools
		 sys-apps/parted
		 dev-python/dbus-python
		 dev-util/glade[python]
		 dev-python/pygtk
		 sys-boot/syslinux
		 dev-python/gnome-vfs-python"

PYTHON_MODNAME="usb-creator"

S="${WORKDIR}/trunk"

src_unpack() {
	distutils_src_unpack
	cd ${S}
	sed -i -e 's:lib/syslinux:share/syslinux:' \
		usbcreator/backend.py \
		|| die "sed usbcreator/backend.py failed."
}

src_install() {
	distutils_src_install
	cd ${S}
	insinto /usr/share/${PN}
	doins gui/usbcreator.glade
	exeinto /usr/share/${PN}
	doexe scripts/install.py
	insinto /usr/share/pixmaps
	doins desktop/usb-creator.png

}
