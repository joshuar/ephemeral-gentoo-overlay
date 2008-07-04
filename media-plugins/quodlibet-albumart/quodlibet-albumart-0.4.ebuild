# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

MY_PN="albumart"
MY_PV="4"
MY_P="${MY_PN}.${MY_PV}"

DESCRIPTION="Quod Libet plugin that downloads album covers from Amazon.com"
HOMEPAGE="http://www.sacredchao.net/quodlibet/attachment/wiki/Plugins/albumart.3.py"
SRC_URI="http://www.sacredchao.net/quodlibet/attachment/wiki/Plugins/${MY_P}.py?rev=latest&format=txt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

RDEPEND="media-sound/quodlibet
		 dev-python/pyaws"

PLUGIN_DEST="/usr/share/quodlibet/plugins/songsmenu"

src_unpack() {
	cp "${DISTDIR}/${MY_P}.py?rev=latest&format=txt" "${WORKDIR}/${MY_PN}.py"
}

src_install() {
	python_version
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/songsmenu"
	newins "${WORKDIR}/${MY_PN}.py" "${MY_PN}.py"
	dodoc "${FILESDIR}/README"
}

pkg_postinst() {
	python_version
	python_mod_compile "/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/songsmenu/${MY_PN}.py"
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/quodlibet/plugins/songsmenu"
}
