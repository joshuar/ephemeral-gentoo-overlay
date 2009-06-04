# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=OESTERHOL
inherit perl-module

DESCRIPTION="Extends Tie::Cache::LRU with expiring"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/Tie-Cache-LRU
	dev-lang/perl"

SRC_TEST=do
