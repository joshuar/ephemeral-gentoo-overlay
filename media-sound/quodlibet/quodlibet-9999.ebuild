# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion distutils

ESVN_REPO_URI="http://svn.sacredchao.net/svn/quodlibet/trunk/quodlibet"

DESCRIPTION="Quod Libet is a GTK+-based audio player written in Python."
HOMEPAGE="http://www.sacredchao.net/quodlibet/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="aac alsa dbus esd ffmpeg flac gnome hal ipod mad mmkeys musepack oss trayicon vorbis"

DEPEND=">=virtual/python-2.4.3-r1
	trayicon? ( >=dev-python/pygtk-2.8 )
	mmkeys? ( >=dev-python/pygtk-2.8 )
	dev-util/intltool"

RDEPEND="${DEPEND}
	>=dev-python/pygtk-2.8
	>=media-libs/mutagen-1.9
	>=media-libs/gst-plugins-good-0.10.2
	>=dev-python/gst-python-0.10.2
	hal? ( sys-apps/hal )
	mad? ( >=media-plugins/gst-plugins-mad-0.10.2 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.2
		>=media-plugins/gst-plugins-ogg-0.10.2 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.2 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.1 )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.0 )
	ffmpeg? ( >=media-plugins/gst-plugins-ffmpeg-0.10.1 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.2 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.2 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10.2 )
	gnome? ( dev-python/gnome-python-extras
		>=media-plugins/gst-plugins-gconf-0.10.3
		>=media-plugins/gst-plugins-gnomevfs-0.10.2
		dev-python/feedparser )
	dbus? ( >=dev-python/dbus-python-0.71 )
	ipod? ( >=media-libs/libgpod-0.3.2-r1 )"

PDEPEND="trayicon? ( media-plugins/quodlibet-trayicon )"


src_unpack() {
	subversion_src_unpack
	cd "${S}/${PN}"
	# no gst-plugins-gconf, attempt to guess the proper pipeline value. Bug #133043, #146728.
	if ! use gnome; then
		local sinktype="alsasink"

		use esd  && sinktype="esdsink"
		use oss  && sinktype="osssink"
		use alsa && sinktype="alsasink"

		elog "Setting the default pipeline to ${sinktype}"

		sed -i -e "s,^          \"gst_pipeline\": \"\",          \"gst_pipeline\": \"${sinktype}\"," config.py
	fi
	# fix broken install functions
	cd "${S}/gdist"
	epatch "${FILESDIR}/${P}-skip-autoinstall-desktop-man-locale-files.patch"
}

src_install() {
	DOCS="README NEWS"
	distutils_src_install
	# svn quodlibet's install routines are broken
	# and I don't know python, so do them the hard way...
	insinto /usr/share/applications
	doins "${S}"/build/share/applications/*.desktop
	doman "${S}"/man/*
	cd "${S}"/build/share/locale
	for locale in *; do
		insinto /usr/share/local/${locale}
		doins -r ${locale}/*
	done
	cd "${S}"/quodlibet/images
	doicon {exfalso,quodlibet}.*
	insinto /usr/share/quodlibet
	doins {audio,device,media}*.png missing-cover.svg
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

	elog ""
	elog "This is an UNOFFICIAL ebuild IN ADDITION to the fact that"
	elog "installing Quod Libet from an ebuild is not supported"
	elog "upstream. If you encounter any problems, you are completely"
	elog "on your own.  DO NOT file bugs anywhere unless you have a fix."
	elog ""
}
