# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Easily prompt a user for information."
HOMEPAGE="http://search.cpan.org/search?query=Term-Prompt&mode=dist"
SRC_URI="mirror://cpan/authors/id/P/PE/PERSICOM/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc"
IUSE=""

DEPEND=">=dev-perl/TermReadKey-2.30"
