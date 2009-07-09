# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

NEED_PYTHON=2.4

inherit distutils python

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python."
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="aac alsa dbus ffmpeg flac hal ipod mad \
mod musepack network oss rss tta vorbis wavpack"

COMMON_DEPEND=">=dev-python/pygtk-2.10"

RDEPEND="${COMMON_DEPEND}
	>=media-libs/mutagen-1.10
	>=dev-python/gst-python-0.10.2
	media-libs/gst-plugins-good
	aac? ( media-plugins/gst-plugins-faad )
	alsa? ( media-plugins/gst-plugins-alsa )
	dbus? ( dev-python/dbus-python )
	ffmpeg? ( media-plugins/gst-plugins-ffmpeg
			  media-libs/gst-plugins-ugly )
	flac? ( media-plugins/gst-plugins-flac )
	hal? ( sys-apps/hal )
	musepack? ( media-plugins/gst-plugins-musepack )
	mod? ( media-plugins/gst-plugins-modplug )
	mad? ( media-plugins/gst-plugins-mad )
	network? ( media-plugins/gst-plugins-gnomevfs )
	oss? ( media-plugins/gst-plugins-oss )
	rss? ( dev-python/feedparser )
	tta? ( media-libs/gst-plugins-bad )
	vorbis? ( media-plugins/gst-plugins-vorbis
			  media-plugins/gst-plugins-ogg )
	wavpack? ( media-plugins/gst-plugins-wavpack )
	ipod? ( media-libs/libgpod[python] )"

DEPEND="${COMMON_DEPEND}
	dev-util/intltool"

DOCS="README HACKING NEWS PKG-INFO"

src_install() {
	distutils_src_install
	python_version
	for ext in png svg; do
		for prog in quodlibet exfalso; do
			dosym /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/images/${prog}.${ext} \
				/usr/share/pixmaps/${prog}.${ext} \
				|| die "copying image file ${prog}.${ext} failed."
		done
	done
}

pkg_postinst() {
	if ! use mad; then
		elog ""
		elog "You do not have the 'mad' USE flag enabled."
		elog "gst-plugins-mad, which is required for mp3 playback, may"
		elog "not be installed. For mp3 support, enable the 'mad'"
		elog "USE flag and emerge =media-sound/${P}."
	fi
	distutils_pkg_postinst
}
