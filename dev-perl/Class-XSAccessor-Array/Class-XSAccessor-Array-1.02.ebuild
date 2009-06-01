# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Generate fast XS accessors without runtime compilation"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/AutoXS-Header
	dev-lang/perl"

SRC_TEST=do
