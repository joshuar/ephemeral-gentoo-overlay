# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils distutils

DESCRIPTION="Simple but powerful recipe-managing application."
HOMEPAGE="http://grecipe-manager.sourceforge.net/"
#MY_P="${PN}-${PV}-${MY_PR}"
SRC_URI="mirror://sourceforge/grecipe-manager/${P}.tar.gz"

LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="rtf gnome-print"
DEPEND="dev-lang/python
dev-python/gnome-python
dev-python/pysqlite
dev-python/pygtk
dev-python/imaging
dev-python/reportlab
gnome-base/libglade
dev-db/metakit
rtf? (dev-python/pyrtf)
gnome-print? (dev-python/gnome-python-extras)"
RDEPEND="${DEPEND}"

pkg_setup() {
	DOCS="README CHANGES TODO FAQ"
}

src_compile() {
	 distutils_src_compile
}

src_install() {
	distutils_src_install
}
