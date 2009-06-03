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
KEYWORDS=""
IUSE="X"

DEPEND="x11-libs/libXtst
		x11-libs/libX11"
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}
	sed -i -e "s:CFLAGS=.*:CFLAGS=${CFLAGS}:" \
		-e "s:LIBS=.*:LIBS=$(pkg-config --libs x11 xtst):" \
		-e "s:INC=.*:INC=$(pkg-config --cflags x11 xtst):" \
		-e "s:LDFLAGS+=.*:LDFLAGS+=\$(LIBS) ${LDFLAGS}:" \
		-e "s:\$(CC):$(tc-getCC):" \
		Makefile \
		|| die "sed Makefile failed."
}


# src_compile() {
# 	cd ${S}
# 	ls
# 	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
# 		|| die "emake failed."
# }
