# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_P="${PN}$(delete_all_version_separators ${PV})_src"

DESCRIPTION="Interactive FITS File Editor."
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/ftools/fv/"
SRC_URI="http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/${PN}/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	cd "${S}/BUILD_DIR"
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

