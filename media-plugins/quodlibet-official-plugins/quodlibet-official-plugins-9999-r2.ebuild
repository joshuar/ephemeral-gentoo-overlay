# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python mercurial

DESCRIPTION="All official plugins for media-sound/quodlibet."
HOMEPAGE="http://code.google.com/p/quodlibet/"
EHG_REPO_URI="https://quodlibet.googlecode.com/hg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#IUSE="automask cddb musicbrainz nautilus replaygain"

S=${WORKDIR}/hg/plugins

RDEPEND=">=media-sound/quodlibet-2.0"
		 # automask? ( dev-python/gnome-vfs-python )
		 # cddb? ( dev-python/cddb-py )
		 # gajim? ( net-im/gajim )
		 # mmkeys? ( dev-python/dbus-python )
		 # musicbrainz? ( dev-python/python-musicbrainz )
		 # nautilus? ( dev-python/libbonobo-python )
		 # replaygain? ( media-libs/gst-plugins-bad )"

pkg_setup() {
		python_version
		export PLUGIN_BASEDIR="/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins"
}

src_install() {
	# # # check and remove any plugins that require
	# # # external packages and not requested
	# # # through USE flags
	# use_plugin automask events/automask.py
	# use_plugin cddb songsmenu/cddb.py
	# use_plugin musicbrainz songsmenu/brainz.py
	# use_plugin replaygain songsmenu/replaygain.py
	# use_plugin mmkeys events/dbusmmkey.py
	# use_plugin gajim events/gajim.py

	for dir in editing events playorder songsmenu; do
		insinto ${PLUGIN_BASEDIR}/${dir}
		doins ${dir}/* || die "failed to install ${dir} plugins."
	done
}

pkg_postinst() {
	for dir in editing events playorder songsmenu; do
		python_mod_compile ${PLUGIN_BASEDIR}/${dir}/*.py
	done
}

pkg_postrm() {
		python_mod_cleanup
}

# function use_plugin() {
# 	use_flag=$1
# 	plugin_file=$2
# 	if ! use ${use_flag}; then
# 		rm -f ${plugin_file}
# 	fi
# }
