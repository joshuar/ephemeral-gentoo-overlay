# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit bzr distutils eutils

DESCRIPTION="Python-based frontend to the Australian TV channel ABC's iView service."
HOMEPAGE="http://jeremy.visser.name/2009/08/30/python-iview/"
EBZR_REPO_URI="http://jeremy.visser.name/bzr/python-iview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND="${DEPEND}
		 dev-python/beautifulsoup
		 media-video/rtmpdump"

PYTHON_DEPEND="2:2.6"

DOCS="README"

src_prepare() {
	bzr_src_prepare
	echo 'Icon=web-browser' >> iview-gtk.desktop \
		|| die "add icon to .desktop file failed."
}
