# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module


DESCRIPTION="Write bzip2 files/buffers."
HOMEPAGE="http://search.cpan.org/search?query=IO-Compress-Bzip2&mode=dist"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/IO-Compress-Bzip2-${PV}.tar.gz"

S=${WORKDIR}/IO-Compress-Bzip2-${PV}

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc sparc-fbsd x86 x86-fbsd"

DEPEND=">=dev-perl/IO-Compress-Base-${PV}
	dev-perl/Compress-Raw-Bzip2"
