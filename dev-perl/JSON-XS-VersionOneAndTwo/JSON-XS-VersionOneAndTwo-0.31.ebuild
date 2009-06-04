# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="Support versions 1 and 2 of JSON::XS"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/JSON-XS
	dev-lang/perl"

SRC_TEST=do
