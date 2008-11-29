# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="0.3.0rc1"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Perl script to convert FLAC files to MP3 format."
HOMEPAGE="http://projects.robinbowes.com/flac2mp3/trac"
SRC_URI="http://projects.robinbowes.com/download/flac2mp3/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-perl/Audio-FLAC-Header
		 dev-perl/Text-Glob
		 dev-perl/MP3-Tag
		 dev-perl/Number-Compare
		 dev-perl/File-Find-Rule"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_P}"

src_compile() {
	return 0
}

src_install() {
	newbin flac2mp3.pl flac2mp3
	dodoc *.txt
}
