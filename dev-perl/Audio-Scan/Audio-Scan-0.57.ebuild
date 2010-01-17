# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="XS parser for MP3, MP4, Ogg Vorbis, FLAC, ASF, WAV, AIFF, Musepack, Monkey's Audio."
HOMEPAGE="http://search.cpan.org/~agrundma/Audio-Scan-0.57/"
SRC_URI="mirror://cpan/authors/id/A/AG/AGRUNDMA/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
IUSE="flac"

DEPEND="flac? ( media-libs/flac )"
