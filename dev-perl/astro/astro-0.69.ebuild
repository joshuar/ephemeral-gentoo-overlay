# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

DESCRIPTION="Assorted astronomical routines for Perl."
HOMEPAGE="http://search.cpan.org/~cphil/Astro-0.69/"
MY_PN="Astro"
SRC_URI="mirror://cpan/authors/id/C/CP/CPHIL/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
SRC_TEST="do"

