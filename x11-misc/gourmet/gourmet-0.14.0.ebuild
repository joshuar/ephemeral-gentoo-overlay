# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils distutils

DESCRIPTION="Simple but powerful recipe-managing application."
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
SRC_URI="mirror://sourceforge/grecipe-manager/${P}.tar.gz"

LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86"
IUSE="rtf gnome-print"
DEPEND="dev-python/gnome-python
		dev-python/pysqlite
		dev-python/imaging
		dev-python/reportlab
		dev-python/sqlalchemy
		gnome-base/libglade
		dev-db/metakit
		rtf? (dev-python/pyrtf)
		gnome-print? (dev-python/gnome-python-extras)"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! (built_with_use dev-db/metakit python) ; then
		eerror "dev-db/metakit was not built with python support"
		die 're-build dev-db/metakit with USE="python"'
	fi
}

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-setup.py.patch"
}

