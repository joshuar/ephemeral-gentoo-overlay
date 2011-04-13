# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools

DESCRIPTION="Free client for Cisco AnyConnect SSL VPN software"
HOMEPAGE="http://www.infradead.org/openconnect.html"
SRC_URI="ftp://ftp.infradead.org/pub/${PN}/${P}.tar.gz
		 http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script -> openconnect-script"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.8m
	dev-libs/libxml2
	gnome-base/gconf"

RDEPEND="${DEPEND}
		 sys-apps/iproute2"

src_prepare() {
	sed -i -e "s|^SSL_CFLAGS.*|SSL_CFLAGS += \$(shell pkg-config --cflags libssl)|" \
		-e "s|^SSL_LDFLAGS.*|SSL_LDFLAGS += \$(shell pkg-config --libs libssl)|" \
		-e "s|^OPT_FLAGS.*|OPT_FLAGS := ${CFLAGS}|" \
		-e "s|\$(EXTRA_LDFLAGS)|${LDFLAGS}|" \
		-e "s|\$(CC)|$(tc-getCC)|" \
		-e "s|\$(AR)|$(tc-getAR)|" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman openconnect.8
	dodoc AUTHORS README.* TODO
	dohtml ${PN}.html
	diropts -m0700
	dodir /etc/openconnect
	insopts -m0700
	insinto /etc/openconnect
	doins ${DISTDIR}/openconnect-script
}

pkg_postinst() {
	elog "Don't forget to turn on TUN support in the kernel."
	elog ""
	elog "Please read the Getting Started section on the"
	elog "openconnect website for using this software:"
	elog "  ${HOMEPAGE}"
}
