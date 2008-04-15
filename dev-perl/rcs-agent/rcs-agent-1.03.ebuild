# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

S=${WORKDIR}/Rcs-Agent-1.03

DESCRIPTION="An RCS archive manipulation method library"
HOMEPAGE="http://search.cpan.org/search?query=Rcs-Agent&mode=dist"
SRC_URI="mirror://cpan/authors/id/N/NI/NICKH/Rcs-Agent-1.03.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc sparc-fbsd x86 x86-fbsd"

DEPEND="dev-perl/String-ShellQuote
	dev-lang/perl"
