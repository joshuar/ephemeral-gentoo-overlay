# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2

DESCRIPTION="Clean up the unknown/invalid gconf keys"
HOMEPAGE="http://code.google.com/p/gconf-cleaner/"
SRC_URI="http://gconf-cleaner.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="gnome"

RDEPEND=">=x11-libs/gtk+-2.20:2
		>=gnome-base/gconf-2.12"
DEPEND="${RDEPEND}
		app-text/scrollkeeper
		sys-devel/gettext
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS NEWS README"
