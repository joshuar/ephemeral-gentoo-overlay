# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="Free compiler for programs written in the proprietary language PureBasic"
HOMEPAGE="https://sourceforge.net/apps/mediawiki/elice/"
SRC_URI="mirror://sourceforge/project/elice/elice%20${PV}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-ruby/racc
	${DEPEND}"

S="${WORKDIR}/all/${P}"

src_prepare() {
	sed -i -e 's|prefix=/usr/local|prefix=/usr|' \
		Makefile \
		|| die "sed Makefile failed."
	epatch ${FILESDIR}/${P}-sdl_gfx.patch
	ruby-ng_src_prepare
}

src_compile() {
	emake || die "make failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	ruby-ng_src_install
	prepalldocs
}
