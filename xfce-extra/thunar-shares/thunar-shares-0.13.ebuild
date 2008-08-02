# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils xfce44

xfce44

DESCRIPTION="Thunar plugin to share files using Samba."
HOMEPAGE="http://thunar-shares.daniel.com.uy/"
SRC_URI="http://thunar-shares.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="primaryuri"

RDEPEND=">=xfce-base/thunar-${THUNAR_MASTER_VERSION}
		 net-fs/samba"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="AUTHORS NEWS README TODO"
USERSHARES_DIR="/var/lib/samba/usershare"
USERSHARES_GROUP="samba"

pkg_preinst() {
	enewgroup samba
	xfce44_pkg_preinst
}

src_install() {
	xfce44_src_install
	dodir ${USERSHARES_DIR}
	fowners root:${USERSHARES_GROUP} ${USERSHARES_DIR}
	fperms 01770 ${USERSHARES_DIR}
}

pkg_postinst() {
	echo
	elog "You will need to edit your samba configuration"
	elog "and add or change it to have the following lines:"
	elog ""
	elog "[global]"
	elog "        security = share"
	elog "        usershare path = /var/lib/samba/usershare"
	elog "        usershare max shares = 100"
	elog "        usershare allow guests = yes"
	elog "        usershare owner only = yes"
	elog ""
	elog "For each user account which will use ${PN}, add"
	elog "it to the samba group:"
	elog ""
	elog "    usermod -a -G ${USERSHARES_GROUP} username"
	echo
	xfce44_pkg_postinst
}
