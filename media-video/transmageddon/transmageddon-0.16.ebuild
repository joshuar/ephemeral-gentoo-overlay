# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Gstreamer-based video transcoder."
HOMEPAGE="http://www.linuxrising.org/"
SRC_URI="http://www.linuxrising.org/transmageddon/files/${P}.tar.bz2"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=media-libs/gst-plugins-good-0.10.15
		>=media-libs/gst-plugins-bad-0.10.13
		>=media-libs/gst-plugins-ugly-0.10.12
		media-plugins/gst-plugins-meta[ffmpeg]
		dev-python/gst-python
		>=dev-python/pygobject-2.18.0
		dev-python/pycairo
		dev-python/pygtk"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
}
