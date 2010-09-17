# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

USE_RUBY="ruby18"

inherit bzr ruby-ng

DESCRIPTION="Free compiler for programs written in the proprietary language PureBasic"
HOMEPAGE="https://sourceforge.net/apps/mediawiki/elice/"
EBZR_REPO_URI="bzr://elice.bzr.sourceforge.net/bzrroot/elice"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~*"

IUSE=""

src_unpack() {
	bzr_src_unpack
	ruby-ng_src_unpack
}

src_prepare() {
	bzr_src_prepare
	ruby-ng_src_prepare
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	ruby-ng_src_install
}
