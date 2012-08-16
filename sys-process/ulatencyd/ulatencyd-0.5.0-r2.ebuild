# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.5"

inherit cmake-utils multilib python systemd

DESCRIPTION="Daemon that controls how the Linux kernel will spend it's resources on the running processes"
HOMEPAGE="https://github.com/poelzi/ulatencyd/"
SRC_URI="https://github.com/downloads/poelzi/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc qt4"

DEPEND="dev-libs/dbus-glib
		|| ( dev-lang/lua dev-lang/luajit )
		dev-lua/luaposix
		dev-python/dbus-python
		qt4? ( dev-python/PyQt4[dbus] )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e 's:${CMAKE_INSTALL_PREFIX}/man:${CMAKE_INSTALL_PREFIX}/share/man:g' \
		docs/CMakeLists.txt \
		|| die "sed fix man page installation failed"
	sed -i -e "s:DESTINATION lib/ulatencyd:DESTINATION $(get_libdir)/ulatencyd:" \
		src/CMakeLists.txt \
		|| die "sed multilib fix failed"
	sed -i -e "s:DESTINATION lib/ulatencyd:DESTINATION $(get_libdir)/ulatencyd:" \
		modules/CMakeLists.txt \
		|| die "sed multilib fix failed"
	if ! use doc; then
		sed -i -e '11,93 s:^:#:' \
			docs/CMakeLists.txt \
			|| die "sed remove doc installation failed"
	fi
	python_convert_shebangs -r 2 .
}

src_install() {
	cmake-utils_src_install
	newinitd ${FILESDIR}/ulatencyd.init ${PN}
}
