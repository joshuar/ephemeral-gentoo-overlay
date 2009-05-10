# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils python mercurial

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python. This is the community driven development version."
HOMEPAGE="http://bitbucket.org/srobertson/quodlibet-testing/wiki/Home"
EHG_REPO_URI="http://bitbucket.org/srobertson/${PN}/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="aac alsa dbus esd ffmpeg flac gnome gstreamer hal ipod mad \
mmkeys musepack oss trayicon tta vorbis xine"

COMMON_DEPEND=">=dev-python/pygtk-2.12"

RDEPEND="${COMMON_DEPEND}
	>=media-libs/mutagen-1.14
	gstreamer? (
		>=media-libs/gst-plugins-good-0.10.2
		>=dev-python/gst-python-0.10.2

		mad? ( >=media-plugins/gst-plugins-mad-0.10.2 )
		vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.2
			>=media-plugins/gst-plugins-ogg-0.10.2 )
		flac? ( >=media-plugins/gst-plugins-flac-0.10.2 )
		aac? ( >=media-plugins/gst-plugins-faad-0.10.1 )
		musepack? ( >=media-plugins/gst-plugins-musepack-0.10.3 )
		ffmpeg? ( >=media-plugins/gst-plugins-ffmpeg-0.10.1
			>=media-libs/gst-plugins-ugly-0.10.2 )
		tta? ( >=media-libs/gst-plugins-bad-0.10.3 )

		alsa? ( >=media-plugins/gst-plugins-alsa-0.10.2 )
		oss? ( >=media-plugins/gst-plugins-oss-0.10.2 )
		esd? ( >=media-plugins/gst-plugins-esd-0.10.2 )
	)
	xine? ( >=media-libs/xine-lib-1.1.0
		dev-python/ctypes )
	gnome? ( dev-python/gnome-python-extras
		>=media-plugins/gst-plugins-gconf-0.10.3
		>=media-plugins/gst-plugins-gnomevfs-0.10.2
		dev-python/feedparser )
	hal? ( sys-apps/hal )
	dbus? ( >=dev-python/dbus-python-0.71 )
	ipod? ( >=media-libs/libgpod-0.5.2 )"

DEPEND="${COMMON_DEPEND}
	dev-util/intltool"

PDEPEND="trayicon? ( media-plugins/quodlibet-trayicon )"

S=${WORKDIR}/${PN}/quodlibet

pkg_setup() {
	if ! use gstreamer && ! use xine; then
		eerror "You must have either gstreamer or xine USE flag enabled."
		die "No backend USE flags enabled."
	fi

	if use ipod && ! built_with_use media-libs/libgpod python; then
		eerror "media-libs/libgpod must be built with 'python' support."
		die "Recompile media-libs/libgpod after enabling the 'python' USE flag"
	fi

	python_version
	export PLUGIN_BASEDIR="/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins"
}

src_unpack() {
	mercurial_src_unpack

	cd "${S}"

	echo `pwd`

	# The backend is configured as gstbe by default.
	if use gstreamer && use xine; then
		elog ""
		elog "You have both backend USE flags (gstreamer and xine) enabled."
		elog "Gstreamer is considered to be more stable of the two, so we have"
		elog "selected it as your default backend."
	elif use gstreamer; then
		elog "Gstreamer backend selected."
	else
		sed -i -e "s,^          \"backend\": \"gstbe\",          \"backend\": \"xinebe\"," quodlibet/config.py \
			|| die "setting xine backend failed."
			elog "Xine backend selected."
	fi
	elog "You can change the backend by editing the ~/.quodlibet/config file."

	# no gst-plugins-gconf, attempt to guess the proper pipeline value. Bug #133043, #146728.
	if ! use gnome; then
		local sinktype="alsasink"

		use esd  && sinktype="esdsink"
		use oss  && sinktype="osssink"
		use alsa && sinktype="alsasink"

		elog "Setting the default pipeline to ${sinktype}"
		sed -i -e "s,^          \"pipeline\": \"\",          \"pipeline\": \"${sinktype}\"," quodlibet/config.py \
			|| die "setting default pipeline failed."
	fi
}

src_install() {

	cd "${S}"

	distutils_src_install

	# link icons to the right place
	python_version
	for ext in png svg; do
		for prog in quodlibet exfalso; do
			dosym /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/images/${prog}.${ext} \
				/usr/share/pixmaps/${prog}.${ext} \
				|| die "copying image file ${prog}.${ext} failed."
		done
	done

	# install base plugins while we are at it
	cd "${S}/../plugins"
	for dir in *; do
		insinto ${PLUGIN_BASEDIR}/${dir}
		doins ${dir}/* || die "failed to install ${dir} plugins."
	done
}

pkg_postrm() {
	distutils_pkg_postrm
	python_mod_cleanup
}

pkg_postinst() {
	if ! use mad; then
		elog ""
		elog "You do not have the 'mad' USE flag enabled."
		elog "gst-plugins-mad, which is required for mp3 playback, may"
		elog "not be installed. For mp3 support, enable the 'mad'"
		elog "USE flag and emerge =media-sound/${P}."
	fi

	if ! use gnome; then
		elog ""
		elog "You do not have the 'gnome' USE flag enabled."
		elog "media-plugins/gst-plugins-gnomevfs may not be installed,"
		elog "so the proper pipeline won't be automatically selected."
		elog "We've tried to select the proper pipeline based on your"
		elog "USE flags, but if we guessed wrong you may have to set"
		elog "'pipeline = ' in your ~/.quodlibet/config file to one"
		elog "of the following: alsasink, osssink, esdsink. To enable"
		elog "automatic selection of the proper pipeline, enable the"
		elog "'gnome' USE flag and emerge =media-sound/${P}."
	fi

	distutils_pkg_postinst
	# compile plugins
	cd "${S}/../plugins"
	for dir in *; do
		python_mod_compile ${PLUGIN_BASEDIR}/${dir}/*.py
	done

}
