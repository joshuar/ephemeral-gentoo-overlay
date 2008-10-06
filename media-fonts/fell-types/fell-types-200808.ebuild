# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

BASE_URI="http://iginomarini.com/fell/wp-content/uploads"
MY_PV="2008/08"
MY_PN="imfell"

DESCRIPTION="A unique collection of old fonts."
HOMEPAGE="http://iginomarini.com/fell/"
SRC_URI="${BASE_URI}/${MY_PV}/${MY_PN}plain27.zip"

LICENSE="fell-types"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="primaryuri"

FONT_SUFFIX="ttf"

pkg_postinst() {
	font_pkg_postinst
	echo
	elog "Please read /usr/portage/licenses/${LICENSE} for notes"
	elog "on using ${PN} in your works."
	echo
}

