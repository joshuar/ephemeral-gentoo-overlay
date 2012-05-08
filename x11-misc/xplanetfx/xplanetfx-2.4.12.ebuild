# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="User-friendly interface to configure, run or daemonize xplanet with HQ capabilities"
HOMEPAGE="http://mein-neues-blog.de/xplanetFX/"
SRC_URI="http://repository.mein-neues-blog.de:9000/archive/${P}_all.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS=""

IUSE=""

RDEPEND="${DEPEND}
		 x11-misc/xplanet
		 media-gfx/imagemagick[perl]
		 dev-perl/libwww-perl
		 sys-devel/bc
		 dev-python/pygtk"

S="${WORKDIR}/usr"

src_install() {
	insinto /usr
	doins -r *
	fperms 0755 /usr/bin/xplanetFX \
		/usr/share/xplanetFX/xplanetFX_gtk
}
