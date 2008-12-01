# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python subversion

DESCRIPTION="All official plugins for media-sound/quodlibet."
HOMEPAGE="http://code.google.com/p/quodlibet/"
ESVN_REPO_URI="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-sound/quodlibet-2.0"

pkg_setup() {
		python_version
		export PLUGIN_BASEDIR="/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins"
}

src_install() {
	for dir in editing events playorder songsmenu; do
		insinto ${PLUGIN_BASEDIR}/${dir}
		doins ${dir}/*
	done
}

pkg_postinst() {
	for dir in editing events playorder songsmenu; do
		python_mod_compile ${PLUGIN_BASEDIR}/${dir}/*.py
	done
	echo
	elog "You will need to install some extra packages for some of"
	elog "the plugins to work:"
	elog ""
	elog "automask: dev-python/gnome-vfs-python"
	elog "nautilus: dev-python/libbonobo-python"
	elog "replaygain: media-libs/gst-plugins-bad"
	elog ""
	elog "You do not need to install these if you do not wish to"
	elog "use those plugins."
	echo
}

pkg_postrm() {
		python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/quodlibet/plugins/"
}
