# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Smooth and simple cursor set created primarily in Inkscape."
HOMEPAGE="http://www.xfce-look.org/content/show.php/Polar+Cursor+Theme?action=content&content=27913"
MY_PN="PolarCursorThemes"
SRC_URI="http://www.xfce-look.org/CONTENT/content-files/27913-${MY_PN}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror binchecks strip"

RDEPEND="x11-libs/libX11
		x11-libs/libXcursor"
DEPEND="${RDEPEND}"

pkg_setup() {
	cursors_base="/usr/share/cursors/xorg-x11/"
}

src_prepare() {
	cd ${WORKDIR}
	find ${WORKDIR} -name '*~' -delete
	for dir in *; do
		rm -fr "${WORKDIR}/${dir}/Source"
	done
}

src_install() {
	dodir "${cursors_base}"
	insinto "${cursors_base}"
	cd ${WORKDIR}
	for dir in *; do
		doins -r ${dir}
	done
}

pkg_postinst() {
	elog "To use this set of cursors, edit or create the file ~/.Xdefaults"
	elog "and add the following line:"
	elog "    Xcursor.theme: ${MY_PN}[-<colour>]"
	elog ""
	elog "To globally use this set of mouse cursors edit the file:"
	elog "   /usr/share/cursors/xorg-x11/default/index.theme"
	elog "and change the line:"
	elog "    Inherits=[current setting]"
	elog "to"
	elog "    Inherits=${MY_PN}[-<colour>]"
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
