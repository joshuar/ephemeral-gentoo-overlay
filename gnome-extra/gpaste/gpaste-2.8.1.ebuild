# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools bash-completion-r1 vala

DESCRIPTION="Clipboard management system"
HOMEPAGE="https://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/downloads/Keruspe/GPaste/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug gnome-shell nls applet"

DEPEND=">=dev-lang/vala-0.14
		>=dev-util/pkgconfig-0.22
		>=dev-libs/glib-2.30
		x11-libs/gtk+:3
		nls? ( >=dev-util/intltool-0.40 )"
RDEPEND="${DEPEND}"

VALA_MIN_API_VERSION=0.14

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
