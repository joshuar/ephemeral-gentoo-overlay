# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Six HTS voices for Festival from the HMM-based Speech Synthesis System (HTS)"
HOMEPAGE="http://hts.sp.nitech.ac.jp/"
BASE_URL="http://hts.sp.nitech.ac.jp/release"
SRC_URI="${BASE_URL}/festvox_nitech_us_awb_arctic_hts-${PV}.tar.bz2 ${BASE_URL}/festvox_nitech_us_bdl_arctic_hts-${PV}.tar.bz2 ${BASE_URL}/festvox_nitech_us_clb_arctic_hts-${PV}.tar.bz2 ${BASE_URL}/festvox_nitech_us_jmk_arctic_hts-${PV}.tar.bz2 ${BASE_URL}/festvox_nitech_us_rms_arctic_hts-${PV}.tar.bz2 ${BASE_URL}/festvox_nitech_us_slt_arctic_hts-${PV}.tar.bz2"

LICENSE="as-is"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}"

pkg_setup() {
	festival_share="/usr/share/festival/voices/english/"
}

src_compile() {
	return 0
}

src_install() {
	dodir "${festival_share}"
	cd "${S}/festival/lib/voices/us"
	cp -rf * "${D}/${festival_share}"
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
	elog "    awb_arctic_hts"
	elog "    bdl_arctic_hts"
	elog "    clb_arctic_hts"
	elog "    jmk_arctic_hts"
	elog "    rms_arctic_hts"
	elog "    slt_arctic_hts"
	elog ""
	elog "You may need to restart festival:"
	elog ""
	elog "    /etc/init.d/festival restart"
}


