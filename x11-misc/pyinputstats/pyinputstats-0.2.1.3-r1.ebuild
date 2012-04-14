# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit distutils

DESCRIPTION="Keyboard and mouse statistics tool"
HOMEPAGE="http://pypi.python.org/pypi/pyInputStats/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${DEPEND}
	dev-python/python-xlib
	dev-python/pysqlite:2
	dev-python/pygtk:2"

pkg_setup() {
    python_set_active_version 2
}
