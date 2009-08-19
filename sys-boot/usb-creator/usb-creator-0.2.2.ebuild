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
KEYWORDS=""
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

S="${WORKDIR}/${PN}.trunk"

src_prepare() {
	sed -i -e 's:lib/syslinux:share/syslinux:' \
		usbcreator/backend.py \
		|| die "sed usbcreator/backend.py failed."
}
