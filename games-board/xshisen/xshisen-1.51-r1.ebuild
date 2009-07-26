# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools flag-o-matic games

DESCRIPTION="Puzzle game using 144 mahjong pieces, objective is to remove all the pieces on the board."
HOMEPAGE="http://www.techfirm.co.jp/~masaoki/xshisen.html"
SRC_URI="http://www.techfirm.co.jp/~masaoki/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="athena +motif"

DEPEND="athena? ( x11-libs/libXaw )
		motif? ( x11-libs/openmotif )
		x11-libs/libXpm"

pkg_setup() {
	LANGS="ja ja_JP ja_JP.JIS7 ja_JP.PCK ja_JP.SJIS ja_JP.eucJP ja_JP.ujis pl"
}


src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:CPPFLAGS:CXXFLAGS:g" \
		-e "s:-I${x_includes}::" \
		-e "s:-L${x_libraries}::" \
		-e 's:LIBS=.*:LIBS="`pkg-config --libs xaw7 xpm` ${LIBS}":' \
		configure.in \
		|| die "sed configure.in failed"
	eautoreconf
}


src_compile() {
	egamesconf \
		$(use_with motif ) \
		|| die "egamesconf failed"
	emake \
		CXX=$(tc-getCXX) \
		|| die "emake failed"
}

src_install() {

	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_STATEDIR}"/${PN}
	doins ${PN}.scores || die "install scores file failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r pixmaps/*

	doman man/*

	# app defaults
	./xshisen -KCONV none < lang/XShisen.ad > XShisen.ad
	insinto /etc/X11/app-defaults
	newins XShisen.ad XShisen
	# language-specific app defaults
	for lang in ${LANGS}; do
		./xshisen -KCONV none < lang/XShisen.ad.${lang} > XShisen.ad.${lang}
		insinto /etc/X11/app-defaults/${lang}
		newins XShisen.ad.${lang} XShisen
	done

	dodoc ChangeLog README

	newicon ${S}/pixmaps/s2/m1.xpm ${PN}.xpm
	make_desktop_entry ${PN} XShisen ${PN}.xpm

	prepgamesdirs
}

