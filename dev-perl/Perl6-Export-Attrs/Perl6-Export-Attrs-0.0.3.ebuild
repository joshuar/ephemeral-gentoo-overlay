# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Implements a Perl 5 native version of what the Perl 6 symbol export mechanism will look like."
HOMEPAGE="http://search.cpan.org/search?query=Perl6-Export-Attrs&mode=dist"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc"
IUSE=""

DEPEND="dev-perl/Attribute-Handlers"
