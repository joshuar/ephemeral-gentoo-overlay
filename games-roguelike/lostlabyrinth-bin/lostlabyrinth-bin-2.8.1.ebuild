# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils games

DESCRIPTION="A roguelike roleplaying game with zelda-like graphics and very high replayability"
HOMEPAGE="http://www.lostlabyrinth.com"

# Set up naming of package
MY_PN="lostlabyrinth"
MY_P=${MY_PN}_${PV}
DOWNLOAD_URL="http://www.lostlabyrinth.com/index.php?p=download"
SRC_URI="mirror://sourceforge/lostlaby/${MY_P}.tar.gz"

RESTRICT="nomirror fetch nostrip"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-libs/libsdl-1.2 || (
		(
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
			x11-libs/libXext )
		virtual/x11 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/laby_${PV}

# pkg_nofetch() {
#	einfo "Please download ${MY_P}.tar.gz from:"
#		einfo ${DOWNLOAD_URL}
#		einfo "(select 'Archive for Linux', under Download)"
#		einfo "and move it to ${DISTDIR}"
# }

src_unpack() {
	cp /usr/portage/distfiles/${MY_P}.tar.gz ${DISTDIR}
		if [ ! -r ${DISTDIR}/${MY_P}.tar.gz ]; then
		  die "cannot read ${MY_P}.tar.gz. Please check the permission and try again."
	fi
	unpack ${MY_P}.tar.gz
	cd ${S}
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${MY_PN}
	local statedir=${GAMES_STATEDIR}/${MY_PN}

	insinto "${statedir}"
	doins highscores.dat settings.txt || die

	# Set up links for writeable files
	dodir "${dir}"
	for filename in {highscores.dat,settings.txt,savenames.sav,laby{1,2,3,4,5,6,7,8,9,10}.sav}; do
		touch "${D}${statedir}/${filename}" || die
		dosym "${statedir}/${filename}" "${dir}/${filename}" || die
		fperms 660 "${statedir}/${filename}" || die
	done

	insinto "${dir}"
	exeinto "${dir}"
	doins graphics.pak sounds.pak laby.xpm
	dodoc readme*
	doexe laby
#	dodir ${GAMES_BINDIR}
#	dosym ${dir}/laby ${GAMES_BINDIR}/laby

	newicon laby.xpm ${MY_PN}.xpm
	games_make_wrapper ${MY_PN} "${dir}/laby" "${dir}"
	make_desktop_entry ${MY_PN} "Lost Labyrinth" ${MY_PN}.xpm

	prepgamesdirs
}
