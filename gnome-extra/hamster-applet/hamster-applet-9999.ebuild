# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_USE_WITH="tk"
PYTHON_DEPEND="2:2.4"

inherit git-2 python waf-utils

DESCRIPTION="Time tracking for the masses"
HOMEPAGE="http://projecthamster.wordpress.com/"
EGIT_REPO_URI="git://git.gnome.org/hamster-applet"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="gnome-base/gnome-control-center
		sys-devel/gettext
		dev-util/intltool"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	git-2_src_unpack
}

pkg_postinst() {
	python_mod_optimize hamster
}

pkg_postrm() {
	python_mod_cleanup hamster
}
