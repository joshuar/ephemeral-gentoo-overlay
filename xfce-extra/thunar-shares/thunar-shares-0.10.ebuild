# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils xfce44

xfce44

DESCRIPTION="Thunar plugin to share files using Samba."
HOMEPAGE="http://code.google.com/p/thunar-shares/"
SRC_URI="http://thunar-shares.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

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
	diropts 01770
	dodir ${USERSHARES_DIR}
	fowners root:${USERSHARES_GROUP} ${USERSHARES_DIR}
	insinto /etc/samba
	doins "${FILESDIR}/smb.conf"
}

pkg_postinst() {
	echo
	einfo "For each user account which will use ${PN}, add"
	einfo "it to the samba group:"
	echo
	einfo "    usermod -a -G ${USERSHARES_GROUP} username"
	echo
	xfce44_pkg_postinst
}
