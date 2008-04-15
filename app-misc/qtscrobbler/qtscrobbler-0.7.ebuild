# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

MY_PN="qtscrob"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Updates a last.fm profile using information from a supported portable music player."
HOMEPAGE="http://qtscrob.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="qt4"

RESTRICT="nomirror"

DEPEND="dev-libs/openssl
net-misc/curl
qt4? ( $(qt4_min_version 4.2) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	# Makefile for cli prog does not read CFLAGS env var.
	# This sed fixes this.
	cd "${S}/src/cli"
	sed -i -e "s:CFLAGS =.*:CFLAGS = \$(INCLUDE) `curl-config --cflags` ${CFLAGS}:" Makefile
}


src_compile() {
	cd "${S}/src/cli"
	emake || die "emake qtscrob cli failed"
	if use qt4; then
		cd "${S}/src/qt"
		qmake "${MY_PN}.pro" || die "qmake qtscrob gui failed"
		emake || die "emake qtscrob gui failed"
	fi
}

src_install() {
	cd "${S}/src/cli"
	newbin scrobble-cli qtscrobbler-cli
	if use qt4; then
		cd "${S}/src/qt"
		newbin qtscrob qtscrobbler
	fi
	cd "${S}"
	dodoc AUTHORS CHANGELOG
}
