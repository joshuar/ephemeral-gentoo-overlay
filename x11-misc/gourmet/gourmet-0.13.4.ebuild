# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Simple but powerful recipe-managing application."
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
MY_PR=2
MY_P="${PN}-${PV}-${MY_PR}"
SRC_URI="mirror://sourceforge/grecipe-manager/${MY_P}.tar.gz"

LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="x86"
IUSE="rtf gnome-print"
DEPEND="dev-python/gnome-python
		dev-python/pysqlite
		dev-python/imaging
		dev-python/reportlab
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
