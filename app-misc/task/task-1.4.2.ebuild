# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A todo list GTD implementation, based on ideas from http://todotxt.org."
HOMEPAGE="http://www.beckingham.net/task.html"
SRC_URI="http://www.beckingham.net/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="primaryuri"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# don't automatically add debug stuff
	sed -i 's:-ggdb3::' src/Makefile.*
}

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TUTORIAL
}
