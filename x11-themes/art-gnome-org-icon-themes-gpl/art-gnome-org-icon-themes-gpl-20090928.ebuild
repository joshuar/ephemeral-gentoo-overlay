# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit gnome2-utils

BASE_URI="http://art.gnome.org/download/themes/icon/"

DESCRIPTION="Collection of icon themes from art.gnome.org with GPL licenses."
HOMEPAGE="http://art.gnome.org/themes/icon/"
SRC_URI="
${BASE_URI}/1002/ICON-BlankOn.tar.gz
${BASE_URI}/1100/ICON-DroplineNeu.tar.bz2
${BASE_URI}/1112/ICON-DroplineNuovo.tar.bz2
${BASE_URI}/1096/ICON-EXperience.tar.gz
${BASE_URI}/1001/ICON-Gartoon.tar.gz
${BASE_URI}/1340/ICON-Gion.tar.bz2
${BASE_URI}/1352/ICON-Gnome218IconTheme.tar.bz2
${BASE_URI}/1376/ICON-GNOMEAlternatives.tar.gz
${BASE_URI}/1136/ICON-Humility.tar.gz
${BASE_URI}/1127/ICON-KearonesIcons.tar.gz
${BASE_URI}/1339/ICON-Lila.tar.bz2
${BASE_URI}/1006/ICON-SmoothGNOME.tar.gz
${BASE_URI}/1053/ICON-Suede2.tar.bz2
${BASE_URI}/1168/ICON-Yasis.tar.bz2
${BASE_URI}/1128/ICON-YattaBlues.tar.gz
"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND="x11-themes/hicolor-icon-theme"

src_install() {
	# remove temp files
	einfo "Removing temporary files from extracted archives..."
	find . -name '*~' -exec rm -f "{}" \;
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

