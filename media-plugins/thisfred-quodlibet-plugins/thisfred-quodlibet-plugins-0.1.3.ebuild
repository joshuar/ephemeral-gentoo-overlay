# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="A few plugins for Quodlibet."
HOMEPAGE="http://code.google.com/p/thisfred-quodlibet-plugins/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="+autoqueue +autosearch +lastfmtagger"

RESTRICT="primaryuri"

RDEPEND="media-sound/quodlibet"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_version
	export PLUGIN_TYPE="events"
	export PLUGIN_DIR="/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/${PLUGIN_TYPE}"
}

src_install() {
	insinto "${PLUGIN_DIR}"
	for p in autoqueue autosearch lastfmtagger; do
		if use ${p}; then
			doins ${p}.py
		fi
	done
	dodoc "${FILESDIR}/README"
}

pkg_postinst() {
	for p in autoqueue autosearch lastfmtagger; do
		if use ${p}; then
			python_mod_compile "${PLUGIN_DIR}/${p}.py"
		fi
	done
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/quodlibet/plugins/events"
}
