# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MODULE_AUTHOR=DANIEL
inherit perl-module

DESCRIPTION="API for reading & writing XSPF Playlists"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${DEPEND}
		dev-perl/Class-Accessor
		dev-perl/TimeDate
		dev-perl/HTML-Parser
		dev-perl/XML-Writer"

mydoc="Changes"

SRC_TEST=do
