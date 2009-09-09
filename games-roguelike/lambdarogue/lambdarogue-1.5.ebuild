# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

MY_PN="LambdaRogue"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Graphical rogue-like game similar to nethack or angband."
HOMEPAGE="http://lambdarogue.net/index.php"
SRC_URI="http://lambdarogue.googlecode.com/files/${MY_P}-src.zip
		 music? ( http://lambdarogue.googlecode.com/files/${MY_P}-music.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sound"

RDEPEND="sound? ( media-sound/mpg123 )"
DEPEND="${RDEPEND}
		dev-lang/fpc
		media-libs/sdl-image[png,jpeg]
		x11-libs/libX11"

S="${WORKDIR}/${MY_P}-src_without-music"

src_prepare() {
	cp ${FILESDIR}/lambdarogue-${PV}.cfg ${S}/lambdarogue.cfg
	if use sound; then
		rm -fr ${S}/music \
			|| die "prep music failed."
		mv -f ${WORKDIR}/${MY_PN}-*-music/music ${S} \
			|| die "prep music failed."
		sed -i -e 's|@@MUSIC@@|True|' \
			${S}/lambdarogue.cfg \
			|| die "prep music failed."
		sed -i -e 's|@@SOUND@@|True|' \
			${S}/lambdarogue.cfg \
			|| die "prep sound failed."
	else
		sed -i -e 's|@@MUSIC@@|False|' \
			${S}/lambdarogue.cfg \
			|| die "prep no music failed."
		sed -i -e 's|@@SOUND@@|False|' \
			${S}/lambdarogue.cfg \
			|| die "prep no sound failed."
	fi

	sed -i -e 's|data/bones.txt|data/bones/bones.txt|g' \
		${S}/*.pp \
		|| die "sed bonesdir failed."

	find ${S} \( -name Thumbs.db -or -name delete.me \) -delete \
		|| die "remove cruft failed."
}

src_install() {

	local gamedir=${GAMES_PREFIX}/${PN}
	local statedir=${GAMES_STATEDIR}/${PN}

	exeinto ${gamedir}
	doexe lambdarogue

	insinto ${gamedir}
	doins -r graphics

	insinto ${gamedir}/data
	doins data/*.txt
	doins -r data/story
	insinto ${gamedir}/data/levels
	doins data/levels/*.txt

	if use sound; then
		insinto ${gamedir}/sound
		doins sound/*.mp3
		dodoc sound/*.txt
		insinto ${gamedir}/music
		doins music/*.mp3
		dodoc music/*.txt
	fi

	dodir ${statedir}/data/levels/random
	dosym ${statedir}/data/levels/random ${gamedir}/data/levels/random
	dodir ${statedir}/saves
	dosym ${statedir}/saves ${gamedir}/saves
	dodir ${statedir}/bones
	dosym ${statedir}/bones ${gamedir}/bones

	insinto ${statedir}
	doins lambdarogue.cfg
	dosym ${statedir}/lambdarogue.cfg ${gamedir}/lambdarogue.cfg

	newgamesbin ${FILESDIR}/lambdarogue-${PV}-wrapper ${PN}

	dodoc docs/{readme,ChangeLog,"image credits"}.txt

	prepgamesdirs

	chmod -R 770 "${D}${statedir}/"* \
		|| die "failed to change perms of ${my_statedir}."
}