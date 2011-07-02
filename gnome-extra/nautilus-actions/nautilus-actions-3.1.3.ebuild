# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2

DESCRIPTION="Nautilus extension for adding user-configurable actions to the context menu"
HOMEPAGE="http://www.nautilus-actions.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc deprecated gconf nls gtk3"

RDEPEND="gconf? ( >=gnome-base/gconf-2.8.0 )
	>=dev-libs/libxml2-2.6
	gnome-base/nautilus
	doc? ( dev-util/gtk-doc )"
DEPEND="nls? ( >=dev-util/intltool-0.35.5 )
		>=dev-libs/glib-2.16
		x11-libs/gtk+:2
		gnome-base/libglade
		gnome-base/libgnome
		gnome-base/libgnomeui
		dev-util/pkgconfig
		${RDEPEND}"

G2CONF="$(use_enable nls) \
		$(use_enable deprecated) \
		$(use_enable gconf) \
		$(use_enable doc gtk-doc)\
		$(use_with gtk3 gtk 3)"

pkg_postinst() {
	if ! use gconf; then
		elog "If you are upgrading from a version of nautilus-actions"
		elog "less than 3.1.0, you should re-emerge this package with"
		elog "the 'gconf' USE flag enabled to install the migration script"
		elog "for converting the old configuration files to a new format."
	else
		elog "You will need to run a migration script to convert some"
		elog "system-wide settings to a new format."
		elog ""
		elog "The typical invocation is:"
		elog "     # /usr/libexec/nautilus-actions/na-gconf2key.sh -delete -nodummy"
		elog ""
		elog "You can then disable the 'gconf' USE flag, if preferred."
	fi
	gnome2_pkg_postinst
}
