# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="A Least-Recently Used cache"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/Carp-Assert
	dev-perl/enum
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Virtual
	dev-lang/perl"

SRC_TEST=do
