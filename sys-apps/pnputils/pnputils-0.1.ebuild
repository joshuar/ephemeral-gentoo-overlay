# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Tools for interacting with Plug and Play BIOSes"
HOMEPAGE="ftp://ftp.kernel.org/pub/linux/kernel/people/helgaas/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/kernel/people/helgaas/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

src_prepare() {
	echo "CC = $(tc-getCC)" > Makefile.head
	echo "LDFLAGS = ${LDFLAGS}" >> Makefile.head
	mv -f Makefile Makefile.tail \
		|| die "failed to prep Makefile."
	cat Makefile.{head,tail} > Makefile
	sed -i -e "s|^CFLAGS.*|CFLAGS = ${CFLAGS}|" \
		Makefile \
		|| die "sed Makefile failed."
}

src_install() {
	dosbin {ls,set}pnp
	doman {ls,set}pnp.8
	dodoc ChangeLog
}
