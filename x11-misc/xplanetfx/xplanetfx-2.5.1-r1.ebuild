# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="3.*"
inherit python

DESCRIPTION="User-friendly interface to configure, run or daemonize xplanet with HQ capabilities"
HOMEPAGE="http://mein-neues-blog.de/xplanetFX/"
SRC_URI="http://repository.mein-neues-blog.de:9000/archive/${P}_all.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
		 x11-misc/xplanet
		 media-gfx/imagemagick[perl]
		 dev-perl/libwww-perl
		 sys-devel/bc
		 dev-python/pygtk"

S="${WORKDIR}/usr"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	insinto /usr
	doins -r *
	fperms 0755 /usr/bin/xplanetFX \
		/usr/share/xplanetFX/xplanetFX_gtk
}
