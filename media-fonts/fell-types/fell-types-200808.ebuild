# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit font

MY_PV="27"
MY_PN="imfellplain"
MY_P="${MY_PN}${MY_PV}"

DESCRIPTION="A unique collection of old fonts."
HOMEPAGE="http://iginomarini.com/fell/"
SRC_URI="http://iginomarini.com/fell/wp-content/uploads/${MY_P}.zip"

LICENSE="fell-types"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

FONT_SUFFIX="ttf"

pkg_postinst() {
	font_pkg_postinst
	echo
	elog "Please read /usr/portage/licenses/${LICENSE} for notes"
	elog "on using ${PN} in your works."
	echo
}

