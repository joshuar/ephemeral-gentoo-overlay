# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils python versionator

MY_PV=$(replace_version_separator _ -)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An adaptive playlist framework that tracks your listening patterns and dynamically adapts to your taste."
HOMEPAGE="http://www.luminal.org/wiki/index.php/IMMS/IMMS"
SRC_URI="http://www.luminal.org/files/imms/${MY_P}.tar.bz2
quodlibet? ( http://ril.endoftheinternet.org/~jojkaart/files/imms-1.0.3.py )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="analyzer audacious bmpx quodlibet remote vorbis"

RESTRICT="nomirror"

DEPEND=">=dev-db/sqlite-3
>=dev-libs/glib-2
dev-libs/libpcre
|| ( media-libs/id3lib media-libs/taglib )
analyzer? ( >=sci-libs/fftw-3.0 sci-libs/torch >=media-sound/sox-14.0 )
remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
vorbis? ( media-libs/libvorbis )
audacious? ( media-sound/audacious )
bmpx? ( media-sound/bmpx )"
RDEPEND="quodlibet? ( media-sound/quodlibet )
${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix command line options for >=sox-14.0
	epatch "${FILESDIR}/${P}-soxcmdline.patch"
	# need to call PKG_PROG_PKG_CONFIG explicitly in configure.ac
	sed -i "s:AC_PROG_INSTALL:AC_PROG_INSTALL\nPKG_PROG_PKG_CONFIG():" \
		configure.ac || die "sed configure.ac failed"
	# re-run autotools
	einfo "Regenerating autotools files..."
	eautoreconf
}

src_compile() {
	cd "${S}"
	econf \
		--without-xmms \
		$(use_enable analyzer ) \
		$(use_enable remote immsremote ) \
		$(use_with audacious ) \
		$(use_with bmpx bmp ) \
		$(use_with vorbis ) \
		|| die "configure failed!"

	emake || die "make failed!"
}

src_install() {
	cd "${S}"
	dobin build/{immsd,immstool} || die "install immsd/immstool failed"

	if use analyzer; then
		dobin build/analyzer || die "install analyzer failed"
	fi

	if use remote; then
		dobin build/immsremote || die "install immsremote failed"
		insinto /usr/share/${PN}
		doins immsremote/immsremote.glade \
			|| die "install immsremote glade failed"
	fi

	if use bmpx; then
		exeinto /usr/$(get_libdir)/bmpx/plugins/imms
		doexe build/libbmpimms*.so || die "install bmplib failed"
	fi

	if use audacious; then
		exeinto /usr/$(get_libdir)/audacious/General
		doexe build/libaudaciousimms*.so \
			|| die "install audaciouslib failed"
	fi

	if use quodlibet; then
		insinto /usr/share/quodlibet/plugins/events
		newins ${DISTDIR}/imms-1.0.3.py imms.py
	fi

	dodoc README AUTHORS || die "dodoc failed"
}

pkg_postinst() {
	if use quodlibet; then
		python_mod_compile /usr/share/quodlibet/plugins/events/imms.py
	fi
}

pkg_postrm() {
	if use quodlibet; then
		python_mod_cleanup /usr/share/quodlibet/plugins/events
	fi
}
