# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="PodBrowser is a documentation browser for Perl."
HOMEPAGE="http://jodrell.net/projects/podbrowser"
SRC_URI="http://jodrell.net/files/podbrowser/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
SRC_TEST="do"

RESTRICT="nomirror"

RDEPEND="dev-perl/Gtk2-PodViewer
	dev-perl/gtk2-gladexml
	dev-perl/gtk2-perl
	dev-perl/Locale-gettext
	dev-perl/Pod-Simple
	dev-perl/URI
	dev-perl/Gtk2-Ex-PodViewer
	dev-perl/Gtk2-Ex-PrintDialog
	dev-perl/Gtk2-Ex-Simple-List
	>=dev-lang/perl-5.8.0
	>=x11-libs/gtk+-2.6.0
	>=x11-themes/gnome-icon-theme-2.10.0
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	DOCS="README"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-makefile.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc ${DOCS}
}
