# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=MATTLAW
inherit perl-module

DESCRIPTION="Utilities for handling Byte Order Marks"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-perl/Test-Exception-0.27
	>=dev-perl/Readonly-1.03
	dev-lang/perl"

SRC_TEST=do
