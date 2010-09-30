# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MODULE_AUTHOR=BDARRAH
inherit perl-module

DESCRIPTION="Parallel looping constructs for Perl programs"
SRC_URI=${SRC_URI/tar.gz/tgz}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

SRC_TEST="do"
