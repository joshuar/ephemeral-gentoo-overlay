# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Nyah Cursors"
HOMEPAGE="http://kyllene.info/cursors-themes"
MY_PN="nyah"
SRC_URI="http://nyaa.freeshell.org/cr/${MY_PN}-${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="binchecks strip"

RDEPEND="x11-libs/libX11
		x11-libs/libXcursor"
DEPEND="${RDEPEND}"

pkg_setup() {
	cursors_base="/usr/share/cursors/xorg-x11/"
}

src_install() {
	dodir "${cursors_base}"
	cd "${D}/${cursors_base}"
	unpack "${A}"
}

pkg_postinst() {
	elog "To use this set of cursors, edit or create the file ~/.Xdefaults"
	elog "and add the following line:"
	elog "    Xcursor.theme: Nyah"
	elog ""
	elog "To globally use this set of mouse cursors edit the file:"
	elog "   /usr/share/cursors/xorg-x11/default/index.theme"
	elog "and change the line:"
	elog "    Inherits=[current setting]"
	elog "to"
	elog "    Inherits=Nyah"
	elog ""
	elog "Note this will be overruled by a user's ~/.Xdefaults file."
	elog ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option  \"HWCursor\"  \"false\""
	ewarn ""
	ewarn "the Device section of your xorg.conf file:"
	ewarn "    Option  \"HWCursor\"  \"false\""
}
