# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX style for a CV (curriculum vitae) with flavour option"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/curve/"
SRC_URI="ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/${PN}.zip"

LICENSE="LPPL-1.2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="primaryuri"

src_install() {
	latex-package_src_doinstall
	dodoc README NEWS THANKS
	insinto /usr/share/doc/${P}/examples
	doins -r examples/*

}
