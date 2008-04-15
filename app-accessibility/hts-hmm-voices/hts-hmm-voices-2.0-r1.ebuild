# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Six HTS voices for Festival from the HMM-based Speech Synthesis System (HTS)"
HOMEPAGE="http://hts.sp.nitech.ac.jp/"
BASE_URL="${HOMEPAGE}release"
PREFIX="festvox_nitech_us"
VOICE="awb_arctic_hts
 bdl_arctic_hts
 clb_arctic_hts
 jmk_arctic_hts
 rms_arctic_hts
 slt_arctic_hts"
for v in ${VOICE}
do
	SRC_URI="${SRC_URI} ${BASE_URL}/${PREFIX}_${v}-${PV}.tar.bz2"
done

LICENSE="hts-voices"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-accessibility/festival"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

pkg_setup() {
	festival_share="/usr/share/festival/voices/english/"
}

src_compile() {
	return 0
}

src_install() {
	dodir "${festival_share}"
	for v in ${VOICE}
	do
		local voicedir="nitech_us_${v}"
		local installdir="${festival_share}/${voicedir}"
		cd "${S}/festival/lib/voices/us/${voicedir}"
		dodir "${installdir}"
		rm -f hts/README.htsvoice
		rm -f hts/COPYING
		cp -pPR festvox "${D}/${installdir}"
		cp -pPR hts "${D}/${installdir}"
		newdoc README "README-voice-${v}"
	done
}

pkg_postinst() {
	elog ""
	elog "To use one of the voices, edit your <HOME>/.festivalrc"
	elog "and add:"
	elog ""
	elog "    (set! voice_default 'voice_cmu_us_<voice>)"
	elog ""
	elog "Where <voice> is one of:"
	elog ""
	for v in ${VOICE}
	do
		elog "    ${v}"
	done
	elog ""
	elog "You may need to restart festival:"
	elog ""
	elog "    /etc/init.d/festival restart"
}


