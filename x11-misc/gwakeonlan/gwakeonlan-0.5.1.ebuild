# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

DESCRIPTION="GTK+ utility to awake machines using the Wake on LAN"
HOMEPAGE="http://code.google.com/p/gwakeonlan/"
SRC_URI="http://gwakeonlan.googlecode.com/files/${PN}_${PV}_all.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="${DEPEND}
		 dev-python/pygtk"
