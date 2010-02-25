# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit fdo-mime

DESCRIPTION="A download manager that works exclusively with aria2."
HOMEPAGE="http://goodies.xfce.org/projects/applications/eatmonkey"
SRC_URI="http://archive.xfce.org/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-misc/aria2
		 dev-ruby/ruby-gtk2"
DEPEND="${RDEPEND}
		>=x11-libs/gtk+-2.12:2
		>=x11-libs/libnotify-0.4.4"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	rm -f ${S}/src/eatmonkey
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed."
}
