# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="Aurora"
MY_P="56438-${MY_PN}-${PV}"
DESCRIPTION="Aurora GTK+2 Engine"

HOMEPAGE="http://www.gnome-look.org/content/show.php/Aurora+Gtk+Engine?content=56438"
SRC_URI="http://www.gnome-look.org/CONTENT/content-files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nomirror"

RDEPEND=">=x11-libs/gtk+-2.10"
DEPEND="${REDPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	# yep, that is right, zipped tars in a zipped tar...
	tar zxf aurora-${PV}.tar.gz
	tar jxf gtkrc_themes.tar.bz2
}

src_compile() {
	cd "${WORKDIR}/aurora-${PV}"
	econf --enable-animation || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/aurora-${PV}"
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${WORKDIR}"
	dodir /usr/share/themes
	insinto /usr/share/themes
	doins -r ${WORKDIR}/Aurora*
}
