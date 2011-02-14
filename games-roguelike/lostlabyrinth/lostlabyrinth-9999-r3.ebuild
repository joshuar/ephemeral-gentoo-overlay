# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games subversion flag-o-matic

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability."
HOMEPAGE="http://www.lostlabyrinth.com"
ESVN_REPO_URI="http://lostlaby.svn.sourceforge.net/svnroot/lostlaby/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="dev-lang/elice
		>=media-libs/sdl-ttf-2.0
		>=media-libs/sdl-mixer-1.2
		>=media-libs/sdl-image-1.2
		>=media-libs/sdl-gfx-1.2
		>=media-libs/sdl-net-1.2"
RDEPEND="${DEPEND}"


pkg_setup() {
	statedir="${GAMES_STATEDIR}/${PN}"
	gamedir="${GAMES_PREFIX}/${PN}"
}

src_prepare() {
	subversion_src_prepare
}

src_compile() {
	cd pb
	elice ${CXXFLAGS} laby.pb \
		|| die "elice laby failed"
}

src_install() {
	cd pb

	exeinto "${gamedir}"
	insinto "${gamedir}"

	# install binary and support files
	doexe laby
	doins {graphics,sounds}.pak \
		|| die "failed installing support files."

	# install docs
	dodoc readme.txt readme_spells.txt FAQ_eng.txt \
		|| die "failed installing documentation."

	# install sounds and images
	doins laby.xpm ballada.mod archonsoflight.xm \
		|| die "failed installing sound and images."

	# install score and settings files
	insinto "${statedir}"
	# set language to english (other languages not
	# installed yet)
	sed -i 's:language =.*:language = english:' \
		settings.txt || die "set language failed."
	doins highscores.dat settings.txt \
		|| die "failed installing state files."

	# install icon, make desktop entry, link binary into bindir
	newicon laby.xpm ${PN}.xpm
	games_make_wrapper ${PN} "${gamedir}/laby" "${gamedir}"
	make_desktop_entry "/usr/games/bin/${PN}" "Lost Labyrinth" ${PN} "Application;Game;AdventureGame;Roleplaying"

	# check and correct permissions
	prepgamesdirs
}
