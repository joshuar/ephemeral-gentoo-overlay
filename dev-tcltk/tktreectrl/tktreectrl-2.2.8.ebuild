# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=0

DESCRIPTION="Multi-column hierarchical listbox widget for the Tk GUI toolkit."
HOMEPAGE="http://tktreectrl.sourceforge.net/"
SRC_URI="mirror://sourceforge/tktreectrl/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4
		>=dev-lang/tk-8.4"

src_compile() {
	sed -i -e 's:^LIBS.*:LIBS = @LDFLAGS_DEFAULT@ @PKG_LIBS@ @LIBS@:' \
		Makefile.in
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc ChangeLog README.txt || die
}

