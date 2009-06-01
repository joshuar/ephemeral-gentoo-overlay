# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="Seamless DB schema up- and down-grades"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-perl/Class-Accessor
	dev-perl/DBI
	dev-perl/File-Slurp
	dev-lang/perl"

