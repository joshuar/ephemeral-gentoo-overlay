# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools bash-completion-r1

DESCRIPTION="Clipboard management system"
HOMEPAGE="https://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/downloads/Keruspe/GPaste/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug gnome-shell nls applet"

DEPEND=">=dev-lang/vala-0.13.4
		dev-util/pkgconfig
		dev-libs/glib
		x11-libs/gtk+
		nls? ( virtual/libintl )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf
	if ! use debug; then
		myconf="--enable-silent-rules"
	else
		mconf="--disable-silent-rules"
	fi
	myconf="${myconf} \
			$(use_enable gnome-shell gnome-shell-extension) \
			$(use_enable nls) \
			$(use_enable applet)"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS TODO
	dobashcomp data/completions/* || die
}
