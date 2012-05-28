# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-2 gnome2

DESCRIPTION="Update extensions installed from https://extensions.gnome.org"
HOMEPAGE="https://github.com/eonpatapon/gnome-shell-extension-updater"
SRC_URI=""
EGIT_REPO_URI="https://github.com/eonpatapon/gnome-shell-extension-updater.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/glib-2.26
	>=gnome-base/gnome-desktop-2.91.6:3[introspection]
	>=app-admin/eselect-gnome-shell-extensions-20111211"
RDEPEND="${COMMON_DEPEND}
	>=dev-libs/gjs-1.29
	dev-libs/gobject-introspection
	>=gnome-base/gnome-shell-3.2
	media-libs/clutter:1.0[introspection]
	net-libs/telepathy-glib[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.26
	gnome-base/gnome-common"

src_unpack() {
	echo `pwd`
	git-2_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst

	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}
