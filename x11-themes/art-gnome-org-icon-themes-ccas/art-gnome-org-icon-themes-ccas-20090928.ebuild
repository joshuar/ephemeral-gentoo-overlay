# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome2-utils

BASE_URI="http://art.gnome.org/download/themes/icon/"

DESCRIPTION="Collection of icon themes from art.gnome.org with CCPL-Attribution-ShareAlike licenses."
HOMEPAGE="http://art.gnome.org/themes/icon/"
SRC_URI="
${BASE_URI}/1049/ICON-DroplineEtiquette.tar.bz2
${BASE_URI}/1297/ICON-Gorilla.tar.bz2
${BASE_URI}/1051/ICON-Iris.tar.bz2
${BASE_URI}/1138/ICON-JiniIconTheme.tar.gz
${BASE_URI}/1269/ICON-OpenWorld.tar.bz2
${BASE_URI}/1111/ICON-StillLife.tar.bz2
${BASE_URI}/1261/ICON-TangoMateria.tar.gz
${BASE_URI}/1150/ICON-UnofficialTango.tar.bz2
"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND="x11-themes/hicolor-icon-theme"

src_install() {
	# remove temp files
	einfo "Removing temporary files from extracted archives..."
	find . -name '*~' -delete
	for icondir in *; do
		if test -d ${icondir}; then
			local IFS=$'\n'
			einfo "Installing ${icondir} icon theme..."
			# find and install documentation
			docfiles=$(find "${icondir}" -type f -and \( -iname readme -or -iname authors -or -iname donate -or -iname todo -or -iname changelog \))
			for d in ${docfiles}; do
				file=$(basename ${d})
				newdoc "${d}" "${icondir}-${file}"
				rm -f "${d}"
			done
			# find and remove non-icon theme files
			find "${icondir}" -type f -and -not \( -name '*.png' -or -name '*.svg' -or -name '*.icon' -or -name '*.theme' \) -exec rm -f "{}" \;
			# now install
			instdir=/usr/share/icons/"${icondir}"
			insinto "${instdir}"
			doins -r "${icondir}"/*
		fi
	done
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

