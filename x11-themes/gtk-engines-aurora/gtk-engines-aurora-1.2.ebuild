# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-murrine/gtk-engines-murrine-0.53.1.ebuild,v 1.5 2007/07/19 13:48:48 angelos Exp $

MY_PN="aurora"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Aurora GTK+2 Engine"

HOMEPAGE="http://www.gnome-look.org/content/show.php/Aurora+Gtk+Engine?content=56438"
URI_PREFIX="http://www.mso.anu.edu.au/~joshua/gentoo/portage/distfiles"
SRC_URI="${URI_PREFIX}/${MY_P}.tar.gz
${URI_PREFIX}/${MY_PN}-gtkrc-themes.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nomirror"

RDEPEND=">=x11-libs/gtk+-2.6"
DEPEND="${REDPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --enable-animation || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir /usr/share/themes
	insinto /usr/share/themes
	doins -r ${WORKDIR}/Aurora*
}
