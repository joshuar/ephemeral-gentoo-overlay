# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

DESCRIPTION="Perl interface to the IRAF CL interactive session. "
HOMEPAGE="http://search.cpan.org/~pratzlaff/Astro-FITS-CFITSIO-1.05/CFITSIO.pm"
MY_PN="Astro-FITS-CFITSIO"
SRC_URI="mirror://cpan/authors/id/P/PR/PRATZLAFF/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="primaryuri"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="dev-lang/perl
>=sci-libs/cfitsio-3.006"
RDEPEND="${DEPEND}"
SRC_TEST="do"

pkg_setup() {
	# module looks for cfitsio install via CFITSIO env var
	# so export that here so it picks up the right path
	export CFITSIO="/usr"
}
