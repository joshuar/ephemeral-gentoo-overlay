# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="User-friendly interface to configure, run or daemonize xplanet with HQ capabilities"
HOMEPAGE="http://mein-neues-blog.de/xplanetFX/"
SRC_URI="http://repository.mein-neues-blog.de:9000/archive/xplanetFX-2.0.20_all.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND="${DEPEND}
		 x11-misc/xplanet
		 media-gfx/imagemagick[perl]
		 dev-python/pygtk"

S="${WORKDIR}/usr"

src_install() {
	dobin bin/${PN}
	insinto /usr/share/applications
	doins share/applications/${PN}.desktop
	insinto /usr/share/pixmaps
	doins share/pixmaps/*
	insinto /usr/share/${PN}
	doins -r share/xplanetFX/*
	fperms 0755 /usr/share/${PN}/{autostart,xplanetFX_gtk,clouds/download_clouds.pl}
}
