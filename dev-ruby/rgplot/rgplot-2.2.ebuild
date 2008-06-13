# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

MY_PN="gnuplot"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Module providing useful methods for interfacing with a Gnuplot process."
HOMEPAGE="http://rubyforge.org/projects/rgplot/"
SRC_URI="http://rubyforge.rubyuser.de/${PN}/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

RDEPEND="sci-visualization/gnuplot"


