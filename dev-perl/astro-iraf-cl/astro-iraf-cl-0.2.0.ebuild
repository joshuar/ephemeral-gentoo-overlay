# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

DESCRIPTION="Perl interface to the IRAF CL interactive session. "
HOMEPAGE="http://search.cpan.org/~sjquinney/"
MY_PN="Astro-IRAF-CL"
SRC_URI="mirror://cpan/authors/id/S/SJ/SJQUINNEY/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="dev-lang/perl"
RDEPEND=">=dev-perl/Expect-1.15
dev-perl/IO-Tty
sci-astronomy/iraf-bin
${DEPEND}"
SRC_TEST="do"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-useoldcl.patch
}
