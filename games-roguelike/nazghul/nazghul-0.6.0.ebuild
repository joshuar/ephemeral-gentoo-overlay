# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games versionator

DESCRIPTION="A rogue-like, top-down, 2d, turn-based computer role-playing game."
HOMEPAGE="http://myweb.cableone.net/gmcnutt/nazghul.html"
MY_PV=$(replace_all_version_separators _)
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

S="${WORKDIR}/${PN}_${MY_PV}"

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog NEWS README"
}

src_compile() {
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	newgamesbin worlds/haxima-1.002/haxima.sh haxima || die "newgamesbin failed"
	rm -f worlds/haxima-1.002/haxima.sh

	# game data
	insinto "${GAMES_DATADIR}"/${PN}/haxima
	doins -r worlds/haxima-*/* || die "doins failed"

	# docs
	dodoc ${DOCS}
	dodoc doc/{GAME_RULES,GHULSCRIPT,MAP_HACKERS_GUIDE,USERS_GUIDE}
	dodir /usr/share/doc/${P}/world_building
	insinto /usr/share/doc/${P}/world_building
	doins doc/world_building/*.txt
	dodir /usr/share/doc/${P}/engine_extension_and_design
	insinto /usr/share/doc/${P}/engine_extension_and_design
	doins doc/engine_extension_and_design/{ENGINE_CLEANUP,ENGINE_DESIGN_NOTES,README}
	newdoc doc/engine_extension_and_design/*TODO* TODO

	# icon and desktop entry
	doicon icons/haxima.png
	make_desktop_entry haxima Nazghul haxima.png

	prepgamesdirs
}

pkg_postinst() {
	elog "To run from the command-line, use:"
	echo
	elog "    haxima"
	echo
	elog "The back-end is nazghul, the front-end"
	elog "(gui) is called haxima."
}



