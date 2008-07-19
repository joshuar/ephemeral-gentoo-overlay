# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

DESCRIPTION="Binaural tones generator."
HOMEPAGE="http://uazu.net/sbagen"
SRC_URI="http://uazu.net/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RESTRICT="nomirror"

DEPEND="media-libs/libmad
		media-libs/libtremor"
RDEPEND="${DEPEND}"

src_compile() {
	append-flags "-DT_LINUX"$(pkg-config --cflags mad)
	$(tc-getCC) ${CFLAGS} sbagen.c ${LDFLAGS} $(pkg-config --libs mad) -lvorbisidec -lpthread -lm -o sbagen \
		|| die "compile sbagen failed."
}

src_install() {
	dobin sbagen
	dodoc {ChangeLog,focus*,holosync,README,SBAGEN,theory*,TODO,wave}.txt
	insinto /usr/share/sounds/${PN}
	doins *.ogg
	docinto scripts
	dodoc scripts/*
	docinto examples
	cp -pPR examples/* ${D}/usr/share/doc/${P}/examples
}
