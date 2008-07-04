# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

DESCRIPTION="Ruby library for parsing the Flexible Image Transport System (FITS) files widely used in astronomy."
HOMEPAGE="http://rubyforge.org/projects/${PN}/"
SRC_URI="mirror://rubyforge/${PN}/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

RDEPEND="sci-libs/cfitsio"


