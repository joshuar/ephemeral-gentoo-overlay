# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils eutils

DESCRIPTION="A graphical shell that sits on top of TaskWarrior"
HOMEPAGE="http://taskwarrior.org/projects/taskwarrior/wiki/Taskhelm"
SRC_URI="http://www.bryceharrington.org/${PN}/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="app-misc/task
		 ${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	make_desktop_entry /usr/bin/taskhelm taskhelm /usr/share/taskhelm/icons/helm.svg 'Office;'
}
