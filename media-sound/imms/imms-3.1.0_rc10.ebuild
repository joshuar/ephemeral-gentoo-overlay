# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

MY_PV=${PV/_/-}
DESCRIPTION="Adaptive playlist framework for dynamically adapting to your listening patterns."
HOMEPAGE="http://imms.luminal.org/"
SRC_URI="http://imms.googlecode.com/files/${PN}-${MY_PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+analyzer remote vorbis +xscreensaver"

DEPEND="dev-db/sqlite:3
		dev-libs/glib:2
		>=dev-libs/libpcre-4.3
		>=dev-util/pkgconfig-0.9.0
		analyzer? ( >=sci-libs/fftw-3.0 >=sci-libs/torch-3 >=media-sound/sox-14.0 )
		remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
		|| ( >=media-libs/taglib-1.0 >=media-libs/id3lib-3.8.0 )
		vorbis? ( media-libs/libvorbis )
		xscreensaver? ( x11-libs/libXext
						x11-libs/libXScrnSaver
						x11-libs/libX11 )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch ${FILESDIR}/${P}-fetcher-debuglog.patch
	epatch ${FILESDIR}/${P}-configure.ac.patch
	sed -i -e "s:^LDFLAGS=:LDFLAGS=${LDFLAGS} :" vars.mk.in || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable analyzer ) \
		$(use_enable remote immsremote ) \
		$(use_with vorbis ) \
		$(use_with xscreensaver screensaver) \
		|| die "configure failed."
}

src_install() {
	dobin build/{immsd,immstool} || die "install immsd/immstool failed."
	use analyzer && dobin build/analyzer || die "install analyzer failed."
	if use remote; then
		dobin build/immsremote || die "install immsremote failed"
		insinto /usr/share/${PN}
		doins immsremote/immsremote.glade || die "install immsremote glade failed"
	fi
	dodoc AUTHORS README
}
