# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Draws a graphical map of network connecting you to the Internet."
HOMEPAGE="http://netmap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="|| ( net-analyzer/traceroute
			  net-analyzer/mtr )
		 media-gfx/graphviz"

src_prepare() {
	sed -i -e '/^CPP_HEADERS/d' \
		-e "s/^CFLAGS.*/CFLAGS=${CFLAGS}/" \
		-e "s/^CC.*/CC=$(tc-getCXX)/" \
		-e "s/ar /$(tc-getAR) /" \
		-e "s/ranlib /$(tc-getRANLIB) /" \
		-e "s/\$(LDFLAGS)/\$(LDFLAGS) ${LDFLAGS}/" \
		{belgolib,makelist,netmap}/Makefile \
		|| die "sed Makefiles failed."
}

src_install() {
	dobin netmap/netmap makelist/makelist
	dodoc CHANGELOG README TODO
	newdoc netmap/README README-netmap
	newdoc netmap/netmap.hostcache netmap.hostcache.example
	newdoc netmap/netmap.failedip netmap.failedip.example
	newdoc makelist/hosts.txt hosts.txt.example
}
