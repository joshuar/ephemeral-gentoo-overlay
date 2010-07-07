# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic games toolchain-funcs

DESCRIPTION="Explore dungeons filled with dangerous monsters in a quest for the Orb of Zot."
HOMEPAGE="http://crawl.develz.org/wordpress/"
MY_PN="stone_soup"
MY_P=${MY_PN}-${PV}
SRC_URI="mirror://sourceforge/crawl-ref/${MY_P}-nodeps.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+tiles"

S="${WORKDIR}/${MY_P}"

DEPEND="sys-libs/ncurses[unicode]
		dev-lang/lua
		media-libs/freetype:2
		dev-db/sqlite:3
		media-libs/libpng
		media-libs/sdl-image[png]
		dev-libs/libpcre[cxx]"
RDEPEND="${DEPEND}
		 app-arch/zip
		 app-arch/unzip
		 media-sound/sox"

pkg_setup() {
	use tiles && export TILES=1
	export V=1
	export prefix=/usr
	export bin_prefix=/usr/bin
	export DATADIR=/usr/share/games/${PN}
	export SAVEDIR=/var/lib/games/${PN}
	games_pkg_setup
}

src_prepare() {
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
	cd ${S}/source
	emake wizard \
		|| die "make failed."
}

src_install() {
	dodoc README.* CREDITS.txt docs/*.{txt,pdf,html}
	doman docs/crawl.6
	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry ${PN} "Dungeon Crawl Stone Soup" ${PN}

	cd ${S}/source
	emake DESTDIR=${D} wizard install \
		|| die "make install failed."
	fperms 770 ${SAVEDIR}/saves/{scores,logfile} \
		|| die "failed to change perms."
}
