# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools eutils

DESCRIPTION="An adaptive playlist framework that tracks your listening patterns and dynamically adapts to your taste."
HOMEPAGE="http://www.luminal.org/wiki/index.php/IMMS/IMMS"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+analyzer audacious vorbis +remote"

DEPEND=">=dev-db/sqlite-3
>=dev-libs/glib-2
dev-libs/libpcre
|| ( media-libs/id3lib media-libs/taglib )
analyzer? ( >=sci-libs/fftw-3.0 sci-libs/torch <media-sound/sox-13.0.0 )
remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
		cd "${S}"
		epatch "${FILESDIR}/${P}-configure.patch"
	fi
}

src_configure() {
	econf \
		$(use_enable analyzer ) \
		$(use_enable remote immsremote ) \
		$(use_with vorbis ) \
		|| die "Configure failed!"
}

src_install() {
	dobin build/immsd || die
	dobin build/immstool || die
	if use analyzer; then
		dobin build/analyzer || die
	fi
	if use remote; then
		dobin build/immsremote || die
		insinto /usr/share/${PN}
		doins immsremote/immsremote.glade
	fi
	if use audacious; then
		exeinto "/usr/lib/audacious/General"
		doexe build/libaudaciousimms*.so || die
	fi
	dodoc README AUTHORS
}
