# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/blueglass-xcursors/blueglass-xcursors-0.4.ebuild,v 1.22 2006/11/27 23:59:04 flameeyes Exp $

DESCRIPTION="The original Comix Cursors."
HOMEPAGE="http://www.xfce-look.org/content/show.php/ComixCursors?content=32627"
MY_PN="ComixCursors"
MY_P="${MY_PN}-${PV}"
SRC_URI="http://www.limitland.de/ComixCursors-0.4.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nomirror"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	cursors_base="/usr/share/cursors/xorg-x11/"
}

src_install() {
	dodir "${cursors_base}"
	cd "${D}/${cursors_base}"
	unpack "${A}"
	rm -f "${D}/${cursors_base}/link-cursors.bash"
}

pkg_postinst() {
	elog "To use this set of cursors, edit or create the file ~/.Xdefaults"
	elog "and add the following line:"
	elog "    Xcursor.theme: ${MY_PN}-<colour>-<size>"
	elog "Where <colour> is one of Black,Blue,Green,Orange,White"
	elog "and <size> is one of Huge,Large,Regular,Small"
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
