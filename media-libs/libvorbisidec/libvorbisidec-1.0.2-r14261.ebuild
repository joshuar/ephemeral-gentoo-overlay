# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools libtool

MY_PV=${PV}+svn${PR#r}
MY_P=${PN}_${MY_PV}

DESCRIPTION='Integer-only Ogg Vorbis decoder, AKA "tremor"'
HOMEPAGE="http://wiki.xiph.org/index.php/Tremor"
SRC_URI="mirror://debian/pool/main/libv/${PN}/${MY_P}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	./autogen.sh --prefix=/usr \
		$(use_enable static-libs static) \
		|| die "./autogen.sh failed"
}

src_install() {
	emake DESTDIR="${D}" install \
		|| die "emake install failed."
	dodoc CHANGELOG README
	if use doc; then
		docinto html
		dodoc doc/*
	fi
}
