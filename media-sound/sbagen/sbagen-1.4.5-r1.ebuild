# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit flag-o-matic

DESCRIPTION="Binaural tones generator."
HOMEPAGE="http://uazu.net/sbagen"
SRC_URI="http://uazu.net/${PN}/${P}.tgz
		 http://uazu.net/sbagen/sbagen-river-1.4.1.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
		media-libs/libmad
		media-libs/tremor"
RDEPEND="${DEPEND}"

src_prepare() {
	rm COPYING.txt mk-msvc.txt readme-windows.txt
}

src_compile() {
	append-flags "-DMP3_DECODE -DOGG_DECODE -DT_LINUX"$(pkg-config --cflags --libs mad vorbisidec)
	$(tc-getCC) ${CFLAGS} sbagen.c ${LDFLAGS} -lpthread -o sbagen \
		|| die "compile sbagen failed."
}

src_install() {
	dobin sbagen || die "install binary failed."
	insinto /usr/share/sounds/${PN}
	doins *.ogg
	dodoc *.txt
	docinto scripts
	dodoc scripts/*
	insinto /usr/share/doc/${P}/examples
	doins -r examples/*
}
