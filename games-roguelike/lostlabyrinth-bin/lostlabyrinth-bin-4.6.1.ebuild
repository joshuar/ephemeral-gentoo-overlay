# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit games

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability."
HOMEPAGE="http://www.lostlabyrinth.com"
SRC_URI_BASE="http://www.lostlabyrinth.com/download_it.php?id=2&file="
SRC_URI="x86? ( ${SRC_URI_BASE}/${PN%-bin}_${PV}.tar.gz )
		 amd64? ( ${SRC_URI_BASE}/${PN%-bin}_${PV}_64x.tar.gz ) "

LICENSE="GPL-2 CC0-1.0-Universal as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=media-libs/sdl-ttf-2.0
		>=media-libs/sdl-mixer-1.2
		>=media-libs/sdl-image-1.2
		>=media-libs/sdl-gfx-1.2
		>=media-libs/sdl-net-1.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/laby_${PV}"

pkg_setup() {
	statedir="${GAMES_STATEDIR}/${PN}"
	gamedir="${GAMES_PREFIX}/${PN}"
}

src_install() {
	exeinto "${gamedir}"
	insinto "${gamedir}"

	# install binary and support files
	doexe laby
	doins -r monsters music sounds graphics.pak \
		|| die "failed installing support files."

	# install docs
	dodoc readme.txt FAQ_eng.txt licences/statement.txt \
		|| die "failed installing documentation."

	# install score and settings files
	insinto "${statedir}"
	# set language to english (other languages not
	# installed yet)
	sed -i 's:language =.*:language = english:' \
		settings.txt || die "set language failed."
	doins highscores.dat settings.txt \
		|| die "failed installing state files."
	dosym "${statedir}/highscores.dat" "${gamedir}/highscores.dat"
	dosym "${statedir}/settings.txt" "${gamedir}/settings.txt"

	# install icon, make desktop entry, link binary into bindir
	newicon laby.xpm ${PN}.xpm
	games_make_wrapper ${PN} "${gamedir}/laby" "${gamedir}"
	make_desktop_entry "/usr/games/bin/${PN}" "Lost Labyrinth" ${PN} "Application;Game;AdventureGame;Roleplaying"

	# check and correct permissions
	prepgamesdirs
}
