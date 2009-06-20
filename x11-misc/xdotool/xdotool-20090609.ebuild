# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Programatically (or manually) simulate keyboard input and mouse activity, move and resize windows, etc."
HOMEPAGE="http://www.semicomplete.com/projects/xdotool/"
SRC_URI="http://semicomplete.googlecode.com/files/${P}.tar.gz"
LICENSE="XDOTOOL"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples"

DEPEND="x11-libs/libXtst
		x11-libs/libX11"
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}
	sed -i -e "s:^CFLAGS=.*:CFLAGS=-std=c99 ${CFLAGS}:" \
		-e "s:^LIBS=.*:LIBS=$(pkg-config --libs x11 xtst):" \
		-e "s:^INC=.*:INC=$(pkg-config --cflags x11 xtst):" \
		-e "s:\$(CC):$(tc-getCC):" \
		-e "s:\$(LDFLAGS): \$(LIBS) \$(LDFLAGS):" \
		-e 's:LDFLAGS+=$(LIBS)::' \
		-e "s:\$(CFLAGS):\$(INC) \$(CFLAGS):" \
		Makefile \
		|| die "sed Makefile failed."
}

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	doman ${PN}.1
	dodoc CHANGELIST README
	if use examples; then
		insinto /usr/doc/${P}/examples
		doins examples/*
	fi
}
