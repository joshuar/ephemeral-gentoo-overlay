# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

BASE_URI="http://art.gnome.org/download/themes/gtk2/"

DESCRIPTION="Collection of GTK+ themes from art.gnome.org with CCPL Attribution  licenses."
HOMEPAGE="http://art.gnome.org/themes/gtk2/"
SRC_URI="
${BASE_URI}/1311/GTK2-CillopMediterranean.tar.gz
${BASE_URI}/1064/GTK2-ClearLooksDarkBlue.tar.gz
${BASE_URI}/1146/GTK2-Clearlooks9x.tar.bz2
${BASE_URI}/1291/GTK2-DarkNice.tar.gz
${BASE_URI}/1067/GTK2-EvilMac.tar.bz2
${BASE_URI}/1345/GTK2-Foresight.tar.bz2
${BASE_URI}/1329/GTK2-MidnightOSX.tar.gz
${BASE_URI}/1356/GTK2-ShinyBlack.tar.gz
${BASE_URI}/1129/GTK2-Tactile.tar.gz
${BASE_URI}/1249/GTK2-TenebrificBlueMods.tar.gz
${BASE_URI}/1099/GTK2-Wonderlooks.tar.gz
${BASE_URI}/1221/GTK2-NuvolaLightBlueGray.tar.bz2
"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND="x11-libs/gtk+:2"

src_install() {
	# remove temp files
	einfo "Removing temporary files from extracted archives..."
	find . -name '*~' -delete
	for themedir in *; do
		if test -d ${themedir}; then
			local IFS=$'\n'
			einfo "Installing ${themedir} icon theme..."
			# find and install documentation
			docfiles=$(find "${themedir}" -type f -and \( -iname readme -or -iname authors -or -iname donate -or -iname todo -or -iname changelog \))
			for d in ${docfiles}; do
				file=$(basename ${d})
				newdoc "${d}" "${themedir}-${file}"
				rm -f "${d}"
			done
			# now install
			instdir=/usr/share/themes/"${themedir}"
			insinto ${instdir}
			doins -r "${themedir}"/*
		fi
	done
}
