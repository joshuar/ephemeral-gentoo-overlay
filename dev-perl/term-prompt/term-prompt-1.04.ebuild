# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

S=${WORKDIR}/Term-Prompt-1.04

DESCRIPTION="Prompt a user"
HOMEPAGE="http://search.cpan.org/search?query=Term-Prompt&mode=dist"
SRC_URI="mirror://cpan/authors/id/P/PE/PERSICOM/Term-Prompt-1.04.tar.gz"

IUSE=""

RESTRICT="primaryuri"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc sparc-fbsd x86 x86-fbsd"

DEPEND=">=dev-perl/TermReadKey-2.30
	dev-lang/perl"
