# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python mercurial

DESCRIPTION="All official plugins for media-sound/quodlibet."
HOMEPAGE="http://code.google.com/p/quodlibet/"
EHG_REPO_URI="https://quodlibet.googlecode.com/hg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="automask burn cddb gajim lastfmsubmitd musicbrainz nautilus replaygain"

S=${WORKDIR}/hg/plugins
PLUGIN_TYPES="editing events playorder songsmenu"

RDEPEND=">=media-sound/quodlibet-2.0
		 automask? ( dev-python/gnome-vfs-python )
		 burn? ( || ( app-cdr/k3b )
					( app-cdr/brasero ) )
		 cddb? ( dev-python/cddb-py )
		 gajim? ( net-im/gajim )
		 lastfmsubmitd? ( media-sound/lastfmsubmitd )
		 musicbrainz? ( dev-python/python-musicbrainz )
		 nautilus? ( dev-python/nautilus-python
					 dev-python/libbonobo-python )
		 replaygain? ( media-libs/gst-plugins-bad )"

pkg_setup() {
		python_version
		export PLUGIN_BASEDIR="/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins"
}

src_install() {
	# check and remove any plugins that require
	# external packages and not requested
	# through USE flags
	use_plugin automask events/automask.py
	use_plugin burn songsmenu/k3b.py
	use_plugin cddb songsmenu/cddb.py
	use_plugin gajim events/gajim_status.py
	use_plugin lastfmsubmitd events/lastfmsubmit.py
	use_plugin musicbrainz songsmenu/brainz.py
	use_plugin nautilus songsmenu/nautilus.py
	use_plugin replaygain songsmenu/replaygain.py

	for dir in ${PLUGIN_TYPES}; do
		insinto ${PLUGIN_BASEDIR}/${dir}
		doins ${dir}/* || die "failed to install ${dir} plugins."
	done
}

pkg_postinst() {
	for dir in ${PLUGIN_TYPES}; do
		python_mod_compile ${PLUGIN_BASEDIR}/${dir}/*.py
	done
}

pkg_postrm() {
		python_mod_cleanup
}

function use_plugin() {
	use_flag=$1
	plugin_file=$2
	if ! use ${use_flag}; then
		rm -f ${plugin_file}
	fi
}
