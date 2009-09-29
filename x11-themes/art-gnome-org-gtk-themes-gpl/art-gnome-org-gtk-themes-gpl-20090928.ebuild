# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

BASE_URI="http://art.gnome.org/download/themes/gtk2/"

DESCRIPTION="Collection of GTK+ themes from art.gnome.org with GPL licenses."
HOMEPAGE="http://art.gnome.org/themes/gtk2/"
SRC_URI="
${BASE_URI}/1361/GTK2-AeroIon.tar.gz
${BASE_URI}/1331/GTK2-Afterhours.tar.gz
${BASE_URI}/1172/GTK2-Alphacube.tar.gz
${BASE_URI}/1325/GTK2-Aquarius.tar.gz
${BASE_URI}/1125/GTK2-BlueHeart.tar.gz
${BASE_URI}/1161/GTK2-Boxx.tar.gz
${BASE_URI}/1316/GTK2-Cillop.tar.gz
${BASE_URI}/1317/GTK2-CillopMidnite.tar.gz
${BASE_URI}/1362/GTK2-CillopGo.tar.gz
${BASE_URI}/1377/GTK2-ClearlooksCompact.tar.bz2
${BASE_URI}/1364/GTK2-ClearlooksDarkLime.tar.gz
${BASE_URI}/1065/GTK2-ClearlooksDarkOrange.tar.gz
${BASE_URI}/1196/GTK2-ClearlooksFonky.tar.bz2
${BASE_URI}/1313/GTK2-ClearlooksLemonGraphite.tar.gz
${BASE_URI}/1086/GTK2-ClearlooksMyst.tar.gz
${BASE_URI}/1305/GTK2-ClearlooksNeXT.tar.gz
${BASE_URI}/1213/GTK2-ClearlooksQuicksilver.tar.bz2
${BASE_URI}/1202/GTK2-ClearlooksVista.tar.bz2
${BASE_URI}/1203/GTK2-ClearlooksVisto.tar.bz2
${BASE_URI}/1066/GTK2-ClearlooksWarning.tar.gz
${BASE_URI}/1087/GTK2-ClearLooksWarningMod.tar.bz2
${BASE_URI}/1195/GTK2-ClearlooksXp.tar.bz2
${BASE_URI}/1068/GTK2-Clearsky.tar.bz2
${BASE_URI}/1285/GTK2-Darkilouche.tar.bz2
${BASE_URI}/1088/GTK2-Dogmastik.tar.gz
${BASE_URI}/1091/GTK2-EasyListening.tar.bz2
${BASE_URI}/1094/GTK2-EasyListeningPale.tar.bz2
${BASE_URI}/1058/GTK2-EXperience.tar.gz
${BASE_URI}/1284/GTK2-Gilouche.tar.gz
${BASE_URI}/1163/GTK2-GmLooks.tar.bz2
${BASE_URI}/1134/GTK2-Gnursid.tar.gz
${BASE_URI}/1092/GTK2-Gonxical.tar.gz
${BASE_URI}/1246/GTK2-GreenHeart.tar.gz
${BASE_URI}/1032/GTK2-IndustrialColorpack.tar.gz
${BASE_URI}/1312/GTK2-Kallisti.tar.gz
${BASE_URI}/1323/GTK2-MarbleIce.tar.gz
${BASE_URI}/1147/GTK2-MarbleLook.tar.gz
${BASE_URI}/1347/GTK2-MurrinaLemonGraphite.tar.gz
${BASE_URI}/1080/GTK2-Neutrino.tar.gz
${BASE_URI}/1309/GTK2-Orade.tar.gz
${BASE_URI}/1122/GTK2-Outcrop.tar.gz
${BASE_URI}/1283/GTK2-PenOSmaster.tar.gz
${BASE_URI}/1010/GTK2-Pharago.tar.gz
${BASE_URI}/1230/GTK2-Polycarbonate.tar.gz
${BASE_URI}/1257/GTK2-PolycarbonateSummer.tar.gz
${BASE_URI}/1271/GTK2-PolycarbonateDark.tar.gz
${BASE_URI}/1170/GTK2-PhlatBlueDubbed.tar.gz
${BASE_URI}/1011/GTK2-Serenity.tar.gz
${BASE_URI}/1123/GTK2-SmoothMech.tar.gz
${BASE_URI}/1004/GTK2-SmoothGNOME.tar.gz
${BASE_URI}/1007/GTK2-SmoothGNOMEExtras.tar.gz
${BASE_URI}/1154/GTK2-TIshForClearlooks.tar.gz
${BASE_URI}/1151/GTK2-TIshBrushedForClearlooks.tar.gz
${BASE_URI}/1180/GTK2-TIshBrushedBlue.tar.gz
${BASE_URI}/1222/GTK2-TIshBrushedOverlaid.tar.gz
${BASE_URI}/1187/GTK2-VistaGray.tar.gz
${BASE_URI}/1126/GTK2-WaterVapor.tar.gz
${BASE_URI}/1033/GTK2-Whiteplate.tar.gz
${BASE_URI}/1084/GTK2-YattaBlues.tar.gz
"

LICENSE="GPL"
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
