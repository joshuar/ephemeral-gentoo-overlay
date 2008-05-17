# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils games subversion

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability"
HOMEPAGE="http://www.lostlabyrinth.com"
ESVN_REPO_URI="https://lostlaby.svn.sourceforge.net/svnroot/lostlaby"

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-libs/sdl-ttf-2.0
		 >=media-libs/sdl-mixer-1.2
		 >=media-libs/sdl-image-1.2
		 >=media-libs/sdl-gfx-1.2"
DEPEND="dev-ruby/racc
		${RDEPEND}"

pkg_setup() {
	statedir="${GAMES_STATEDIR}/${PN}"
	gamedir="${GAMES_PREFIX}/${PN}"
}

src_compile() {
	cd elice
	# firstly, build elice
	emake || die "emake elice failed."
	# now make sure CFLAGS and CXXFLAGS are respected in the Makefile
	sed -i  \
		-e "s:CFLAGS=.*:CFLAGS=${CFLAGS}\nCXXFLAGS=${CXXFLAGS}:" \
		-e 's:g++ $(CFLAGS):g++ $(CXXFLAGS):' \
		-e "s:g++:$(tc-getCXX):" \
		Makefile || die "sed failed."
	# now build lostlabyrinth
	emake laby-svn || die "emake laby-svn failed."
}

src_install() {
	cd "${S}/elice/labysvn"

	exeinto "${gamedir}"
	insinto "${gamedir}"

	# install binary and support files
	doexe laby || die "failed installing binary."
	doins {graphics,sounds}.pak \
		|| die "failed installing support files."

	# install docs
	dodoc readme.txt readme_spells.txt FAQ_eng.txt \
		|| die "failed installing documentation."

	cd "${S}/pb"

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


	# create links and saved game files
	for filename in {highscores.dat,settings.txt,savenames.sav,laby{1,2,3,4,5,6,7,8,9,10}.sav};
	do
		touch "${D}/${statedir}/${filename}" || die
		dosym "${statedir}/${filename}" "${gamedir}/${filename}" || die
		fperms 660 "${statedir}/${filename}" || die
	done

	# install icon, make desktop entry, link binary into bindir
	newicon laby.xpm ${PN}.xpm
	games_make_wrapper ${PN} "${gamedir}/laby" "${gamedir}"
	make_desktop_entry "/usr/games/bin/${PN}" "Lost Labyrinth" ${PN}.xpm "Application;Game;AdventureGame;Roleplaying"

	# check and correct permissions
	prepgamesdirs
}
