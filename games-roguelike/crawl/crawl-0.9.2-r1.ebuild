# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games toolchain-funcs

DESCRIPTION="Explore dungeons filled with dangerous monsters in a quest for the Orb of Zot."
HOMEPAGE="http://crawl.develz.org/wordpress/"
MY_PN="stone_soup"
MY_P=${MY_PN}-${PV}
SRC_URI="mirror://sourceforge/crawl-ref/${MY_P}-nodeps.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug sound +tiles wizard"

S="${WORKDIR}/${MY_P}"

DEPEND="sys-libs/ncurses[unicode]
		sys-devel/bison
		sys-devel/flex
		dev-libs/libpcre[cxx]
		dev-lang/lua
		dev-db/sqlite:3
		tiles? ( dev-util/pkgconfig
				 media-libs/libpng
				 media-libs/sdl-image[png]
				 media-libs/freetype:2 )"
RDEPEND="${DEPEND}
		 app-arch/zip
		 app-arch/unzip
		 sound? ( media-sound/sox )"

pkg_setup() {
	use tiles && export TILES=1
	use debug && export V=1
	export prefix=${GAMES_PREFIX}
	export bin_prefix=${GAMES_PREFIX}/bin
	export DATADIR=${GAMES_PREFIX}/${PN}
	export SAVEDIR='~/.config/crawl'
	export SHAREDIR=${GAMES_STATEDIR}/${PN}
	games_pkg_setup
}

src_prepare() {
	cd ${S}*
	sed -i -e "s|^AR =.*|AR = $(tc-getAR)|" \
		-e "s|^RANLIB =.*|RANLIB = $(tc-getRANLIB)|" \
		-e "s|^CC =.*|CC = $(tc-getCC)|" \
		-e "s|^CXX =.*|CXX = $(tc-getCXX)|" \
		-e "s|-O2|${CFLAGS}|g" \
		-e 's|LDFLAGS += $(CFOPTIMIZE) $(CFOPTIMIZE_L)|LDFLAGS += $(CFOPTIMIZE) '"${LDFLAGS}"'|' \
		-e "s|^INSTALL_UGRP :=.*|INSTALL_UGRP := ${GAMES_USER}:${GAMES_GROUP}|" \
		source/makefile \
		|| die "sed makefile failed."
}

src_compile() {
	cd ${S}*/source
	if use wizard; then
		emake wizard || die "make wizard failed."
	else
		emake || die "make failed."
	fi
}

src_install() {
	cd ${S}*
	dodoc README.* CREDITS.txt docs/*.{txt,pdf,html}
	doman docs/crawl.6
	if use tiles; then
		doicon ${FILESDIR}/${PN}.png
		make_desktop_entry ${PN} "Dungeon Crawl Stone Soup" ${PN}
	fi
	cd ${S}*/source
	if use wizard; then
		emake DESTDIR=${D} wizard install \
			|| die "make wizard install failed."
	else
		emake DESTDIR=${D} install \
			|| die "make install failed."
	fi
	prepgamesdirs
}

pkg_postinst() {
	if ! use tiles; then
		echo
		elog "You need a UTF-8 locale to play crawl."
		echo
	fi
}