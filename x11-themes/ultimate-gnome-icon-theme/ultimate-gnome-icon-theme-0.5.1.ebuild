# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome2-utils

MY_PN="UltimateGnome"
MY_P="${MY_PN}.${PV}"

DESCRIPTION="A distro independant icon theme that doesn't contain any copyright violating icons."
HOMEPAGE="http://code.google.com/p/ultimate-gnome/"
SRC_URI="http://ultimate-gnome.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND="x11-themes/hicolor-icon-theme"

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/share/icons/"${MY_PN}"
	doins -r "${S}"/*
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
