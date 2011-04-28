# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=3

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils mercurial

DESCRIPTION="Ex Falso / Quod Libet - A Music Library/Editor/Player"
HOMEPAGE="http://code.google.com/p/quodlibet/"
EHG_REPO_URI="http://quodlibet.googlecode.com/hg/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus gstreamer ipod network rss"

COMMON_DEPEND=">=dev-python/pygtk-2"
RDEPEND="${COMMON_DEPEND}
	media-libs/mutagen
	gstreamer? ( dev-python/gst-python:0.10
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-meta:0.10 )
	!gstreamer? ( media-libs/xine-lib )
	network? ( media-plugins/gst-plugins-gnomevfs )
	rss? ( dev-python/feedparser )
	dbus? ( dev-python/dbus-python )
	ipod? ( media-libs/libgpod[python] )"
 DEPEND="${COMMON_DEPEND}
	dev-util/intltool"

src_prepare() {
	if ! use gstreamer; then
		sed -i \
			-e '/backend/s:gstbe:xinebe:' \
			${PN}/${PN}/config.py || die
	fi
	sed -i \
		-e 's/"gst_pipeline": ""/"gst_pipeline": "alsasink"/' \
		${PN}/${PN}/config.py || die
	distutils_src_prepare
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
