# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils games subversion flag-o-matic

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability"
HOMEPAGE="http://www.lostlabyrinth.com"
ESVN_REPO_URI="https://lostlaby.svn.sourceforge.net/svnroot/lostlaby"

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-ruby/racc
		>=media-libs/sdl-ttf-2.0
		>=media-libs/sdl-mixer-1.2
		>=media-libs/sdl-image-1.2
		>=media-libs/sdl-gfx-1.2
		dev-libs/DirectFB"
RDEPEND="${DEPEND}"

pkg_setup() {
	statedir="${GAMES_STATEDIR}/${PN}"
	gamedir="${GAMES_PREFIX}/${PN}"
}

src_compile() {
	# -O2 optimisation level leads to excessive memory
	# usage when compiling main program, assuming -O3
	# does worse
	# --as-needed linker flag causes problems
	# which I need to work out
	replace-flags -O3 -O2
	filter-ldflags -Wl,--as-needed
	cd elice
	# five substitutions:
	# - add CFLAGS, CXXFLAGS and LDFLAGS to Makefile
	# - use CXXFLAGS when compiling with g++
	# - use pkg-config for finding SDL lib flags
	# - add LDFLAGS to link command line
	# - don't assume compiler is called g++
	sed -i  \
		-e "s:CFLAGS=.*:CFLAGS=${CFLAGS}\nCXXFLAGS=${CXXFLAGS}\nLDFLAGS=${LDFLAGS}:" \
		-e 's:g++ $(CFLAGS):g++ $(CXXFLAGS):' \
		-e 's:-I/usr/include/SDL -lSDL:`pkg-config --cflags --libs sdl`:' \
		-e 's:-lSDL_gfx:-lSDL_gfx $(LDFLAGS):' \
		-e "s:g++:$(tc-getCXX):" \
		Makefile || die "sed failed."
	# build failed on a machine dual-core machine with -j3
	# so use -j1 for builds to be safe.
	# firstly, build elice
	emake -j1 || die "emake elice failed."
	# now build lostlabyrinth
	emake -j1 laby-svn || die "emake laby-svn failed."
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
