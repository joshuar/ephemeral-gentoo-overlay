# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

MY_PN="faience"

DESCRIPTION="Scalable icon theme based on Faenza"
HOMEPAGE="http://tiheum.deviantart.com/art/Faience-icon-theme-255099649"
SRC_URI="http://www.deviantart.com/download/255099649/${MY_PN}_icon_theme_by_tiheum-d47vo5d.zip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/faenza-icon-theme"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	for a in Faience{,-Azur,-Claire,-Ocre}; do
		tar -zxvf ${a}.tar.gz 1> /dev/null 2>&1
	done
}

src_install() {
	for d in Faience{,-Azur,-Claire,-Ocre}; do
		insinto /usr/share/icons/${d}
		doins -r ${d}/*
	done
	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
