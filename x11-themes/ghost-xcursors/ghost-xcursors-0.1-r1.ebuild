# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="ghost"
MY_P="13090-${MY_PN}"

DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://xfce-look.org/content/show.php?content=13090"
SRC_URI="http://xfce-look.org/CONTENT/content-files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nomirror binchecks strip"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	INSTALL_LOCATION="/usr/share/cursors/xorg-x11/${MY_PN}"
	DOCS="README"
}

src_install() {
	dodir ${INSTALL_LOCATION}
	insinto ${INSTALL_LOCATION}
	cd "${S}"
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
