# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="GUI application for programming Logitech Harmony remote controls"
HOMEPAGE="http://sourceforge.net/projects/congruity/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/wxpython:2.8
		dev-libs/libconcord[python]"
RDEPEND="${DEPEND}"


src_install() {
	emake RUN_UPDATE_DESKTOP_DB=0 \
		PREFIX="/usr" \
		DESTDIR="${D}" install || die
	dodoc README.txt Changelog
}
