# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=TONYC
inherit perl-module

DESCRIPTION="An XS implementation of POE::Queue::Array"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/POE
	dev-lang/perl"

SRC_TEST=do
