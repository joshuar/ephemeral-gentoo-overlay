# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils games

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability"
HOMEPAGE="http://www.lostlabyrinth.com"
MY_PN="lostlabyrinth"
MY_P=${MY_PN}_${PV}
SRC_URI="http://www.lostlabyrinth.com/download/${MY_P}.tar.gz"

RESTRICT="nomirror nostrip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-libs/libsdl-1.2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/laby_${PV}

pkg_setup() {
	statedir="${GAMES_STATEDIR}/${MY_PN}"
	gamedir="${GAMES_PREFIX_OPT}/${MY_PN}"
}

src_install() {
	cd "${S}"

	# install score and settings files
	insinto "${statedir}"
	doins highscores.dat settings.txt || die "failed installing state files"

	# install binary and support files
	exeinto "${gamedir}"
	insinto "${gamedir}"
	doexe laby
	doins graphics.pak sounds.pak laby.xpm

	# install docs
	dodoc readme.txt readme_spells.txt FAQ_eng.txt

	# create links and saved game files
	for filename in {highscores.dat,settings.txt,savenames.sav,laby{1,2,3,4,5,6,7,8,9,10}.sav};
	do
		touch "${D}/${statedir}/${filename}" || die
		dosym "${statedir}/${filename}" "${gamedir}/${filename}" || die
		fperms 660 "${statedir}/${filename}" || die
	done

	# install icon, make desktop entry, link binary into bindir
	newicon laby.xpm ${MY_PN}.xpm
	games_make_wrapper ${MY_PN} "${gamedir}/laby" "${gamedir}"
	make_desktop_entry "/usr/games/bin/${MY_PN}" "Lost Labyrinth" ${MY_PN}.xpm "Application;Game;AdventureGame;Roleplaying"

	# check and correct permissions
	prepgamesdirs
}
