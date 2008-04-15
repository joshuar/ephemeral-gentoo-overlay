# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="A diary or journal application that supports multiple diaries/journals and encryption."
HOMEPAGE="http://www.public.iastate.edu/~chris129/code/ejourn/"
SRC_URI="http://www.public.iastate.edu/~chris129/code/${PN}/Downloads/${P}.tar.bz2"

LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPENDS="dev-libs/libgcrypt
x11-libs/gtk+"

S="${WORKDIR}/eJourn"

src_compile() {
	cd "${S}"
	epatch "${FILESDIR}/${PN}-mainmakefile.patch"
	append-flags "-I`pwd`/include"
	append-ldflags "-L${S}"
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}/usr" install || die "install failed"
	dodoc README AUTHORS DEVELOPERS CHANGELOG TODO ID
	make_desktop_entry ${PN}-gui ${PN} /usr/share/${PN}/img/${PN}.png
}
