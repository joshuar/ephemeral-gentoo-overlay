# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Module for weeding out MPEG audio frames out of a file handle."
HOMEPAGE="http://search.cpan.org/~nuffin"
SRC_URI="mirror://cpan/authors/id/N/NU/NUFFIN/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/perl-Module-Build
		${DEPEND}"

