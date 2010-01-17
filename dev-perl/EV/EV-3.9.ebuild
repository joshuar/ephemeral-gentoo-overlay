# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Interface to libev, a high performance full-featured event loop."
HOMEPAGE="http://search.cpan.org/~mlehmann/EV-3.9/"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/libev-${PV}"
