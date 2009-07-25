# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=2

inherit distutils

DESCRIPTION="Python Bindings for the MusicBrainz XML Web Service"
HOMEPAGE="http://musicbrainz.org"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="examples"

RDEPEND=">=media-libs/libdiscid-0.1.0
		 >=dev-python/ctypes-0.9.0"
DEPEND="${RDEPEND}"

DDOCS="AUTHORS.txt CHANGES.txt PKG-INFO README.txt"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${P}/examples
		doins ${S}/examples/*
	fi
}