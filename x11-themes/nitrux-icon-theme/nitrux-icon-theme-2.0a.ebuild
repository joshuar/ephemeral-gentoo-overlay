# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

MY_PN="nitrux"

DESCRIPTION="Part of The Nitrux Artwork Project and was created to be used in the upcoming NITRUX OS"
HOMEPAGE="http://gnome-look.org/content/show.php/Nitrux+OS+Icons?content=154496"
SRC_URI="http://www.deviantart.com/download/293634207/${MY_PN}_os_icons_by_deviantn7k1-d4utllr.7z -> ${P}.7z"
LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	for d in NITRUX{,-Azure,-Buttons,-Clear-All,-Dark,-Mint}; do
		insinto /usr/share/icons/${d}
		doins -r ${d}/*
	done
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
