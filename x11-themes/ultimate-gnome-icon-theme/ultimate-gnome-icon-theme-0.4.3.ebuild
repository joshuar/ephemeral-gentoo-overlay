# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2-utils

MY_PN="UltimateGnome"
MY_P="${MY_PN}.${PV}"

DESCRIPTION="A distro independant icon theme that doesn't contain any copyright violating icons."
HOMEPAGE="http://code.google.com/p/ultimate-gnome/"
SRC_URI="http://ultimate-gnome.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64 ia64"
IUSE=""

RESTRICT="binchecks strip primaryuri"

RDEPEND="x11-themes/hicolor-icon-theme"

S="${WORKDIR}/${MY_PN}"

src_install() {
	dodir /usr/share/icons/"${MY_PN}"
	cp -pPR "${S}"/* "${D}"/usr/share/icons/"${MY_PN}"
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
