# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=CHORNY
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="Convert DateTimes to/from epoch seconds"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-perl/DateTime
	>=dev-perl/Params-Validate-0.91"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
