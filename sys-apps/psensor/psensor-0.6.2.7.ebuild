# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2

DESCRIPTION="Graphical hardware monitor"
HOMEPAGE="http://wpitchoune.net/blog/?page_id=109"
SRC_URI="http://wpitchoune.net/${PN}/files/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="hddtemp libnotify nls nvidia video_cards_nvidia"

DEPEND="sys-apps/lm_sensors
		x11-libs/gtk+
		gnome-base/gconf
		gnome-base/libgtop
		sys-apps/help2man
		hddtemp? ( app-admin/hddtemp )
		libnotify? ( x11-libs/libnotify )
		nvidia? ( sys-power/nvclock )
		video_cards_nvidia? ( || (
		   >=x11-drivers/nvidia-drivers-100.14.09
		   media-video/nvidia-settings ) )"

RDEPEND="${DEPEND}
		 >=dev-util/pkgconfig-0.9
		 dev-util/intltool"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-gtop=yes
		$(use_enable nls)"
}
