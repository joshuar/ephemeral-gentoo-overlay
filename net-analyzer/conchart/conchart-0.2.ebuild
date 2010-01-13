# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Tool to visualise the timing of network connections."
HOMEPAGE="http://sourceforge.net/projects/conchart/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap
		dev-cpp/tclap"

S="${WORKDIR}/${PN}"

src_prepare() {

	sed -i -e "s/^CFLAGS.*/CFLAGS=${CFLAGS} -I./" \
		-e "s/^CPPFLAGS.*/CPPFLAGS=${CPPFLAGS} -I./" \
		-e "s:^LDFLAGS.*:LDFLAGS=${LDFLAGS} $(pcap-config --libs):" \
		-e "s/^CC.*/CC=$(tc-getCXX)/" \
		-e "s/ar /$(tc-getAR) /" \
		-e "s/ranlib /$(tc-getRANLIB) /" \
		board/Makefile || die "sed board/Makefile failed."

	sed -i -e "s/^CFLAGS.*/CFLAGS=${CFLAGS} -Iboard/" \
		-e "s/^CPPFLAGS.*/CPPFLAGS=${CPPFLAGS}/" \
		-e "s:^LDFLAGS.*:LDFLAGS=${LDFLAGS} $(pcap-config --libs) board/libboard.a:" \
		-e "s/^CC.*/CC=$(tc-getCXX)/" \
		-e "s/ar /$(tc-getAR) /" \
		-e "s/ranlib /$(tc-getRANLIB) /" \
		-e '/strip $(OEXE)/d' \
		Makefile || die "sed Makefile failed."
}

src_install() {
	dobin conchart
	dodoc README
}
