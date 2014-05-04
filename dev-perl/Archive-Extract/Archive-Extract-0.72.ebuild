# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.72
inherit perl-module

DESCRIPTION="A generic archive extracting mechanism for Perl"

LICENSE="|| ( Artistic GPL-1 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker
virtual/perl-IPC-Cmd
virtual/perl-File-Spec
virtual/perl-File-Path
virtual/perl-Params-Check
virtual/perl-Module-Load-Conditional
virtual/perl-Locale-Maketext-Simple"

RDEPEND="${DEPEND}"

SRC_TEST=do
