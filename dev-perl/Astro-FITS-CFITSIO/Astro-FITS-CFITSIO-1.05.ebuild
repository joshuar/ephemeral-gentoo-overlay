# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Perl extension for using the cfitsio library (sci-libs/cfitsio)."
HOMEPAGE="http://search.cpan.org/~pratzlaff/Astro-FITS-CFITSIO-1.05/CFITSIO.pm"
SRC_URI="mirror://cpan/authors/id/P/PR/PRATZLAFF/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="primaryuri"

DEPEND=">=sci-libs/cfitsio-3.006"
RDEPEND="${DEPEND}"

pkg_setup() {
	# module looks for cfitsio install via CFITSIO env var
	# so export that here so it picks up the right path
	export CFITSIO="/usr"

	perl-module_pkg_setup
}
