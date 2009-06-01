# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=JGMYERS
inherit perl-module flag-o-matic

DESCRIPTION="Encode::Detect - An Encode::Encoding subclass that detects the encoding of data"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-ExtUtils-CBuilder"

SRC_TEST=do

src_compile() {
	append-ldflags '-lstdc++'
	perl-module_src_compile
}
