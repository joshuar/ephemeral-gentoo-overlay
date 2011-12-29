# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools libtool

MY_PV=${PV}+svn${PR#r}
MY_P=${PN}_${MY_PV}

DESCRIPTION='Integer-only Ogg Vorbis decoder, AKA "tremor"'
HOMEPAGE="http://wiki.xiph.org/index.php/Tremor"
SRC_URI="mirror://debian/pool/main/libv/${PN}/${MY_P}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static )
}

src_install() {
	emake DESTDIR="${D}" install \
		|| die "emake install failed."
	dodoc CHANGELOG README
	docinto html
	dodoc doc/*
}
