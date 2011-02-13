# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2 versionator

DESCRIPTION="Nautilus extension for adding user-configurable actions to the context menu"
HOMEPAGE="http://www.nautilus-actions.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib
	x11-libs/gtk+
	gnome-base/libglade
	gnome-base/libgnome
	gnome-base/libgnomeui
	gnome-base/gconf
	dev-libs/libxml2
	gnome-base/nautilus"
DEPEND="dev-util/intltool
	dev-util/pkgconfig
	${RDEPEND}"
