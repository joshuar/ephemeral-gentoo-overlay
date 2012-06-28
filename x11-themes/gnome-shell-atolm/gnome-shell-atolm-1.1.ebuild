# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="This is a GNOME Shell theme based on the Atolm GTK2 theme."
HOMEPAGE="http://half-left.deviantart.com/art/GNOME-Shell-Atolm-204534789"
SRC_URI="http://www.deviantart.com/download/204534789/gnome_shell____atolm_by_half_left-d3drw1x.zip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome X"

RDEPEND="gnome-base/gnome-shell"

S=${WORKDIR}

src_install() {
	insinto /usr/share/themes/Atolm
	doins -r Atolm-3.2/*
}
