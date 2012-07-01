# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils

MY_PN="awoken"
DESCRIPTION="A scalable icon theme called AwOken"
HOMEPAGE="http://alecive.deviantart.com/art/AwOken-163570862"
SRC_URI="http://www.deviantart.com/download/163570862/${MY_PN}_by_alecive-d2pdw32.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( x11-themes/gnome-icon-theme )
	x11-themes/hicolor-icon-theme
	gnome-extra/zenity
	media-gfx/imagemagick"

RESTRICT="binchecks strip"

S="${WORKDIR}/AwOken-${PV}"

src_prepare() {
	for theme in AwOken{,Dark,White}; do
		tar zxf ${theme}.tar.gz || die
	done
	sed -i -e "s:\$DIR/\$ICNST/Installation_and_Instructions.pdf:/usr/share/doc/${P}/Installation_and_Instructions.pdf:"  AwOken/awoken-icon-theme-customization
}

src_install() {
	for theme in AwOken{,Dark,White}; do
		insinto /usr/share/icons/${theme}
		doins -r ${theme}/{clear,extra} || die
		doins ${theme}/index.theme
		doins ${theme}/awoken-icon-theme-customization-*
	done
	dobin AwOken/awoken-icon-theme-customization{,-clear}
	dodoc AwOken/Installation_and_Instructions.pdf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
