# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

DESCRIPTION="A rogue-like, top-down, 2d, turn-based computer role-playing game."
HOMEPAGE="http://myweb.cableone.net/gmcnutt/nazghul.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="media-libs/libsdl
		media-libs/sdl-image[png]
		media-libs/libpng"

DOCS="AUTHORS ChangeLog NEWS README doc/GAME_RULES doc/GHULSCRIPT doc/MAP_HACKERS_GUIDE
		doc/USERS_GUIDE"

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	newgamesbin worlds/haxima-1.002/haxima.sh haxima || die "newgamesbin failed"
	rm -f worlds/haxima-1.002/haxima.sh
	insinto /usr/share/applications
	doins haxima.desktop
	doicon icons/haxima.png

	insinto "${GAMES_DATADIR}"/${PN}/haxima
	doins -r worlds/haxima-*/* || die "doins failed"

	dodoc ${DOCS}

	prepgamesdirs
}