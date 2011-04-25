# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2

DESCRIPTION="Nautilus extension for adding user-configurable actions to the context menu"
HOMEPAGE="http://www.nautilus-actions.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc deprecated gconf nls"

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

G2CONF="--with-gtk=2 \
		$(use_enable nls) \
		$(use_enable deprecated) \
		$(use_enable gconf) \
		$(use_enable doc gtk-doc)"

