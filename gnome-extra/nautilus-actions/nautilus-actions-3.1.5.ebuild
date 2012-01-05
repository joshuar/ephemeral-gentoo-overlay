# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2

DESCRIPTION="Nautilus extension for adding user-configurable actions to the context menu"
HOMEPAGE="http://www.nautilus-actions.org/"
SRC_URI="http://www.nautilus-actions.org/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc deprecated gconf nls static-libs"

RDEPEND=">=dev-libs/libxml2-2.6
		 gnome-base/nautilus
		 doc? ( dev-util/gtk-doc )"
DEPEND="nls? ( >=dev-util/intltool-0.35.5 )
		>=dev-libs/glib-2.16
		x11-libs/gtk+
		gnome-base/libglade
		gnome-base/libgnome
		gnome-base/libgnomeui
		>=dev-util/pkgconfig-0.9.0
		${RDEPEND}"

G2CONF="$(use_enable nls) \
		$(use_enable deprecated) \
		$(use_enable gconf) \
		$(use_enable doc gtk-doc) \
		$(use_enable static-libs static)"

pkg_postinst() {
	elog "If you are upgrading from a version of nautilus-actions"
	elog "less than 3.1.0 you should ensure you have the 'gconf'"
	elog "USE flag enabled and then read README-GCONF in the"
	elog "documentaion directory for important mandatory steps"
	elog "needed to upgrade this package."
	elog ""
	gnome2_pkg_postinst
}
