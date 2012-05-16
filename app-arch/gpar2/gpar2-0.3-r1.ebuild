# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="GUI for verifying and repairing PAR and PAR2 recovery sets"
HOMEPAGE="http://sourceforge.net/projects/parchive/"
SRC_URI="mirror://sourceforge/project/parchive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/libpar2
		dev-libs/libsigc++:2
		dev-cpp/gtkmm:2.4
		>=dev-util/pkgconfig-0.9.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/applications
	doins ${PN}.desktop
	doicon gnome-logo-icon-transparent.png
}
