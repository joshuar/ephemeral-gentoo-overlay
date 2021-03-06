# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="X11 mouse theme, clean and simple, with a smooth shape and appealing transparency"
HOMEPAGE="http://www.limitland.de/flatbedcursors.html"
MY_PN="FlatbedCursors"
SRC_URI="http://www.limitland.de/flatbedcursors/${MY_PN}-${PV}.tar.bz2
		 http://www.limitland.de/flatbedcursors/${MY_PN}-LH-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="binchecks strip"

RDEPEND="x11-libs/libX11
		 x11-libs/libXcursor"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	insinto /usr/share/cursors/xorg-x11/
	doins -r ${WORKDIR}/*
	rm ${D}/usr/share/cursors/xorg-x11/link-cursors.sh
}

pkg_postinst() {
	elog "To use this set of cursors, edit or create the file ~/.Xdefaults"
	elog "and add the following line:"
	elog "    Xcursor.theme: ${MY_PN}-[colour|type|size]"
	elog "See /usr/share/cursors/xorg-x11 for all the colour/type/sizes"
	elog "available."
	elog ""
	elog "To globally use this set of mouse cursors edit the file:"
	elog "   /usr/share/cursors/xorg-x11/default/index.theme"
	elog "and change the line:"
	elog "    Inherits=[current setting]"
	elog "to"
	elog "    Inherits=${MY_PN}-<colour>-<size>"
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
