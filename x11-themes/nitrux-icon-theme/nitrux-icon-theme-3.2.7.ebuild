# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

MY_PN="nitrux"

DESCRIPTION="Part of The Nitrux Artwork Project and was created to be used in the upcoming NITRUX OS"
HOMEPAGE="http://deviantn7k1.deviantart.com/art/Nitrux-293634207"
SRC_URI="http://store.nitrux.in/files/NITRUX.tar.gz -> ${P}.tar.gz"
LICENSE="CCPL-Attribution-ShareAlike-NonCommercial-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	insopts -m644
	diropts -m755
	insinto /usr/share/icons/NITRUX
	doins -r NITRUX/*
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
