# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="Toolkit for RTMP streams."
HOMEPAGE="http://rtmpdump.mplayerhq.hu/"
SRC_URI="http://rtmpdump.mplayerhq.hu/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="+ssl"

DEPEND="ssl? ( dev-libs/openssl )
		!ssl? ( net-libs/gnutls )"
RDEPEND="${DEPEND}"


src_prepare() {
	sed -i -e "s|CC=.*|CC=$(tc-getCC)|" \
		-e "s|LD=.*|LD=$(tc-getLD)|" \
		-e "s|OPT=.*|OPT=${CFLAGS}|" \
		-e "s|LDFLAGS=.*|LDFLAGS=${LDFLAGS} \$(XLDFLAGS)|" \
		Makefile || die "sed Makefile failed."

	if ! use ssl; then
		sed -i -e "s|#CRYPTO=GNUTLS|CRYPTO=GNUTLS|" \
			Makefile || die "sed Makefile failed."
	fi
}

src_compile() {
	emake posix || die "emake failed"
}

src_install() {
	for b in rtmpdump rtmpgw rtmpsrv rtmpsuck; do
		dobin ${b} || die "dobin ${b} failed."
	done
	dolib librtmp/librtmp.a
	doman rtmpdump.1 rtmpgw.8
	dodoc README ChangeLog
}
