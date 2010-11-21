# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome.org

# NetworkManager likes itself with capital letters
MY_PN=${PN/networkmanager/NetworkManager}

DESCRIPTION="NetworkManager OpenConnect plugin."
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome nls"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=net-misc/openconnect-2.26
	>=dev-libs/dbus-glib-0.74
	gnome? (
		>=x11-libs/gtk+-2.6
		gnome-base/gconf:2
		gnome-base/gnome-keyring
		gnome-base/libglade:2.0
		gnome-base/libgnomeui
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	ECONF="--disable-more-warnings
		$(use_with gnome)
		$(use_enable nls)"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS
}
