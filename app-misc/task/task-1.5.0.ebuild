# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A todo list GTD implementation, based on ideas from http://todotxt.org."
HOMEPAGE="http://www.beckingham.net/task.html"
SRC_URI="http://www.beckingham.net/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog DEVELOPERS NEWS README"

src_prepare() {
	# don't automatically add debug stuff
	sed -i 's:-ggdb3::' src/Makefile.*
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ${DOCS}
}
