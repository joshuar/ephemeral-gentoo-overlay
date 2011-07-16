# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Equinox GTK+ Theme Engine"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=121881"
SRC_URI="http://gnome-look.org/CONTENT/content-files/121881-equinox-${PV}.tar.gz
		 http://gnome-look.org/CONTENT/content-files/140449-equinox-themes-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10:2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/equinox-${PV}

src_configure() {
	econf --disable-dependency-tracking --enable-animation
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	nonfatal dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/themes
	nonfatal doins -r ../Equinox*
}
