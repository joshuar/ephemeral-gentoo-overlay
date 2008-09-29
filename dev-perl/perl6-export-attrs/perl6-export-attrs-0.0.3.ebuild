# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

S=${WORKDIR}/Perl6-Export-Attrs-${PV}

DESCRIPTION="Implements a Perl 5 native version of what the Perl 6 symbol export mechanism will look like."
HOMEPAGE="http://search.cpan.org/search?query=Perl6-Export-Attrs&mode=dist"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/Perl6-Export-Attrs-${PV}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc sparc-fbsd x86 x86-fbsd"

DEPEND="dev-perl/attribute-handlers"
