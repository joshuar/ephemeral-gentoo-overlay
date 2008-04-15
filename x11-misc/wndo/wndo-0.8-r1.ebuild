# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A small suite of complementary tools for adding behavioral extensions to Gnome, Xfce, Fluxbox and other window managers."
HOMEPAGE="http://wijjo.com/project/?c=wndo"
SRC_URI="http://wijjo.com/file_download/19/${P}.tar.gz"

LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome xosd"
DEPEND="dev-python/cmdo
x11-libs/libICE
x11-libs/libSM
x11-libs/libX11
x11-libs/libXau
x11-libs/libXdmcp
x11-libs/libXmu
x11-libs/libXt
x11-libs/libXtst"
RDEPEND="xosd? ( x11-libs/xosd )
gnome? ( gnome-extra/zenity )
x11-apps/xprop
x11-apps/xwininfo
${DEPEND}"

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog COPYING NEWS README readme.html REFERENCE reference.html TODO TUTORIAL tutorial.html"
}

src_unpack() {
	unpack ${A}
	cd "${S}/wndo-ctrl"
	epatch "${FILESDIR}/${P}-ctrl.patch"
	cd "${S}/wndo-pick"
	epatch "${FILESDIR}/${P}-pick.patch"
	cd "${S}/wndo-spy"
	epatch "${FILESDIR}/${P}-spy.patch"
}



src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ${DOCS}
}
