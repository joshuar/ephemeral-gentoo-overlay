# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Powerful application launcher providing a specialized bash session in a small terminal window"
HOMEPAGE="http://code.google.com/p/bashrun2/"
SRC_URI="http://bashrun2.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-terms/xterm
		 ${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README || die
}
