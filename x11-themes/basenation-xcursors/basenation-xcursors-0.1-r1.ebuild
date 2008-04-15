# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="BASEnation"
MY_P="18832-${MY_PN}-${PV}"

DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://xfce-look.org/content/show.php?content=18832"
SRC_URI="http://xfce-look.org/CONTENT/content-files/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nomirror binchecks strip"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	DOCS="COPYING NEWS README-Base README-Grounation"
	INSTALL_LOCATION="/usr/share/cursors/xorg-x11/${MY_PN}"
}

src_install() {
	dodir ${INSTALL_LOCATION}
	insinto ${INSTALL_LOCATION}
	cd "${S}"
	doins index.theme
	doins -r cursors
	dodoc ${DOCS}
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: ${MY_PN}"
	einfo ""
	einfo "You can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	einfo ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "   /usr/share/cursors/xorg-x11/default/index.theme"
	einfo "and change the line:"
	einfo "    Inherits=[current setting]"
	einfo "to"
	einfo "    Inherits=${MY_PN}"
	einfo ""
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	einfo ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option  \"HWCursor\"  \"false\""
	ewarn ""
	ewarn "the Device section of your xorg.conf file:"
	ewarn "    Option  \"HWCursor\"  \"false\""
}
