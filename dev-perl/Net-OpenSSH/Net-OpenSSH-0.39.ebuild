# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="Perl SSH client package implemented on top of OpenSSH"
HOMEPAGE="http://search.cpan.org/~salva/"
SRC_URI="mirror://cpan/authors/id/S/SA/SALVA/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="net-misc/openssh
		 ${DEPEND}"
