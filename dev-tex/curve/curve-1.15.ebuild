# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/curve/curve-1.11.ebuild,v 1.2 2006/12/03 14:15:42 pylon Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX style for a CV (curriculum vitae) with flavour option"
SRC_URI="ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/${PN}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/curve/"
LICENSE="LPPL-1.2"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

RESTRICT="primaryuri"

src_install() {

	latex-package_src_doinstall styles

	dodoc *.tex *.pdf README NEWS THANKS
}
