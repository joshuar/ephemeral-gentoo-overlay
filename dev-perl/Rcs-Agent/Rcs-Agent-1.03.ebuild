# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="An RCS archive manipulation method library"
HOMEPAGE="http://search.cpan.org/search?query=Rcs-Agent&mode=dist"
SRC_URI="mirror://cpan/authors/id/N/NI/NICKH/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/String-ShellQuote"
