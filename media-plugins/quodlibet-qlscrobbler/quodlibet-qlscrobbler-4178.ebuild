# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

MY_PN="qlscrobbler"

DESCRIPTION="Audioscrobbler client for Quod Libet"
HOMEPAGE="http://www.sacredchao.net/quodlibet/file/trunk/plugins/events/${MY_PN}.py"
SRC_URI="http://www.sacredchao.net/quodlibet/browser/trunk/plugins/events/${MY_PN}.py?rev=${PV}&format=txt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

RDEPEND="media-sound/quodlibet"

src_unpack() {
	cp "${DISTDIR}/${MY_PN}.py?rev=${PV}&format=txt" "${WORKDIR}/${MY_PN}.py"
	cd ${WORKDIR}
#	epatch ${FILESDIR}/qlscrobbler_proto_1.2.patch
	epatch ${FILESDIR}/qlscrobbler-0.9.1.patch
}

src_install() {
	python_version
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/events"
	newins "${WORKDIR}/${MY_PN}.py" "${MY_PN}.py"
	dodoc "${FILESDIR}/README"
}

pkg_postinst() {
		python_version
		python_mod_compile "/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/events/${MY_PN}.py"
}

pkg_postrm() {
		python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/quodlibet/plugins/events"
}
