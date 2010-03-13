# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils flag-o-matic games git toolchain-funcs

DESCRIPTION="Explore dungeons filled with dangerous monsters in a quest for the Orb of Zot."
HOMEPAGE="http://crawl-ref.sourceforge.net/"
EGIT_REPO_URI="git://crawl-ref.git.sourceforge.net/gitroot/crawl-ref/crawl-ref"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="pcre sound"

# S="${WORKDIR}/${P}/crawl-ref"

DEPEND="sys-libs/ncurses[unicode]
		dev-lang/lua
		media-libs/freetype:2
		dev-db/sqlite:3
		media-libs/libpng
		media-libs/libsdl
		media-libs/sdl-image[png]
		pcre? ( dev-libs/libpcre[cxx] )"
RDEPEND="${DEPEND}
		 app-arch/zip
		 app-arch/unzip
		 sound? ( media-sound/sox )"

pkg_setup() {
	my_statedir=${GAMES_STATEDIR}/${PN}/state
	my_datadir=${GAMES_DATADIR}/${PN}
	games_pkg_setup
}

src_prepare() {
	cd crawl-ref/source
	append-flags -DUSE_TILE -DUNIX -DCLUA_BINDINGS -fsigned-char
	local pkgconfig_pkgs="freetype2 libpng lua SDL_image sdl sqlite3"

	# epatch ${FILESDIR}/${PN}-${PV}-fix-path-problems.patch

	sed -i -e 's:^MAKEFILE ?=.*:MAKEFILE ?= makefile_tiles.unix:' \
		-e 's:$(OTHER) ::' \
		source/makefile \
		|| die "sed main makefile failed."

	if use pcre; then
		append-flags "-DREGEX_PCRE"
		pkgconfig_pkgs="${pkgconfig_pkgs} libpcre"
	fi

	if use sound; then
		sed -i -e 's|// #define SOUND_PLAY_COMMAND|#define SOUND_PLAY_COMMAND|' \
			source/AppHdr.h \
			|| die "enable sound failed."
	fi

	local pkg_libs=$(pkg-config --libs ${pkgconfig_pkgs})
	local pkg_cflags=$(pkg-config --cflags ${pkgconfig_pkgs})

		# -e "s|^CFOTHERS :=.*|CFOTHERS := '-DSAVE_DIR_PATH=\"${my_statedir}\"' '-DDATA_DIR_PATH=\"${my_datadir}/\"'|" \

	sed -i -e "s:^CXX =.*:CXX = $(tc-getCXX):" \
		-e 's:${CXX}:$(CXX):' \
		-e 's:$(CFLAGS):$(CFLAGS) $(INCLUDES):' \
		-e 's:${CFLAGS}:$(CFLAGS) $(INCLUDES):' \
		-e "s|^CFOTHERS :=.*|CFOTHERS := '-DSAVE_DIR_PATH=\"${my_statedir}\"'|" \
		-e 's|^CFOTHERS +=.*||g' \
		-e "s|^CFLAGS.*|CFLAGS := ${CFLAGS} \$(CFOTHERS)|" \
		-e "s:^LDFLAGS =.*:LDFLAGS = ${LDFLAGS}:" \
		-e "s|^INCLUDES :=.*|INCLUDES := -Iutil -I. -Irltiles ${pkg_cflags}|" \
		-e "s|^LIB =.*|LIB := ${pkg_libs} -lGL -lGLU -lSDL_image|" \
		-e "s|^YCFLAGS.*|YCFLAGS := ${CFLAGS} \$(INCLUDES)|" \
		-e 's|UNICODE_GLYPHS = n|UNICODE_GLYPHS = y|' \
		-e 's|^GAME_DEPENDS :=.*|GAME_DEPENDS := $(DESTTILEFILES) $(OBJECTS)|' \
		source/makefile_tiles.unix \
		|| die "sed makefile_tiles.unix failed."

	sed -i -e "s:^CXX =.*:CXX = $(tc-getCXX):" \
		-e 's:${CXX}:$(CXX):' \
		-e "s:\${CFLAGS}:\$(CFLAGS) ${pkg_cflags}:" \
		-e "s:\${LDFLAGS}:\${LDFLAGS} ${pkg_libs}:" \
		source/rltiles/makefile.unix \
		|| die "sed makefile_tiles.unix failed."

}

src_compile() {
	cd ${S}/source
	emake -j1 \
		|| die "make failed."
}

src_install() {
	insinto ${my_datadir}/dat
	doins -r source/dat/*
	insinto ${my_datadir}/settings
	doins -r settings/*
	insinto ${my_datadir}/docs
	doins docs/*.txt

	dogamesbin source/crawl
	newbin ${FILESDIR}/crawl-wrapper crawl
	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry ${PN} "Dungeon Crawl Stone Soup" ${PN}.png

	dodoc README.{txt,pdf} CREDITS.txt
	doman docs/crawl.6

	dodir ${my_statedir}

	prepgamesdirs

	fowners root:games ${my_statedir} \
		|| die "failed to change ownership of ${my_statedir}."
	fperms 770 ${my_statedir} \
		|| die "failed to change perms of ${my_statedir}."
}