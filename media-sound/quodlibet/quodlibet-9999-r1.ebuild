# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

PYTHON_DEPEND="2:2.6"

inherit distutils eutils mercurial python

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python."
HOMEPAGE="http://code.google.com/p/quodlibet/"
EHG_REPO_URI="http://quodlibet.googlecode.com/hg/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gstreamer ipod network rss"

COMMON_DEPEND=">=dev-python/pygtk-2.14"
RDEPEND="${COMMON_DEPEND}
	>=media-libs/mutagen-1.19
	gstreamer? ( dev-python/gst-python:0.10
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-meta:0.10 )
	!gstreamer? ( media-libs/xine-lib )
	network? ( media-plugins/gst-plugins-gnomevfs )
	rss? ( dev-python/feedparser )
	dbus? ( >=dev-python/dbus-python-0.71 )
	ipod? ( >=media-libs/libgpod-0.5.2[python] )"
 DEPEND="${COMMON_DEPEND}
	dev-util/intltool"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	if ! use gstreamer; then
		sed -i \
			-e '/backend/s:gstbe:xinebe:' \
			${PN}/${PN}/config.py || die
	fi
	sed -i \
		-e 's/"gst_pipeline": ""/"gst_pipeline": "alsasink"/' \
		${PN}/${PN}/config.py || die
}

src_compile() {
	cd ${WORKDIR}/${PN}-${PV}/${PN}
	distutils_src_compile
}

src_install() {
	cd ${WORKDIR}/${PN}-${PV}/${PN}
	distutils_src_install
	dodoc HACKING NEWS README
	doicon quodlibet/images/{exfalso,quodlibet}.{png,svg}
}
