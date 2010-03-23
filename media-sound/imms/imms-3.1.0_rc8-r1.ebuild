# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools eutils python versionator

MY_PV=$(replace_version_separator _ -)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Adaptive playlist framework for dynamically adapting to your listening patterns."
HOMEPAGE="http://imms.luminal.org/"
SRC_URI="http://imms.googlecode.com/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+analyzer +remote vorbis xscreensaver"

DEPEND=">=dev-db/sqlite-3
		>=dev-libs/glib-2
		>=dev-libs/libpcre-4.3
		dev-libs/glib
		|| ( >=media-libs/id3lib-3.8.0 >=media-libs/taglib-1.0 )
		analyzer? ( >=sci-libs/fftw-3.0 >=sci-libs/torch-3 >=media-sound/sox-14.0 )
		remote? ( >=gnome-base/libglade-2.0 >=x11-libs/gtk+-2 )
		vorbis? ( media-libs/libvorbis )
		xscreensaver? ( x11-misc/xscreensaver )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e "s|^LDFLAGS=.*|LDFLAGS=${LDFLAGS} -L. @LIBS@|" \
		vars.mk.in || die "sed vars.mk.in failed"
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
