# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Gtk-based reading system console messages like xconsole."
HOMEPAGE="http://gxconsole.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

KEYWORDS="~x86"

IUSE="X"

RESTRICT="primaryuri"

DEPEND=">=x11-libs/gtk+-2
		dev-util/pkgconfig"
RDEPEND="${DEPEND}
		 x11-libs/gksu"

S="${WORKDIR}/${PN}"

src_install() {
	 emake install DESTDIR="${D}" || die "Install failed"
	 dodoc AUTHORS ChangeLog FAQ NEWS README
}


pkg_postinst() {
	echo
	elog "/dev/console needs to exist for gxconsole to work."
	elog ""
	elog "You can create it with the following commands:"
	elog ""
	elog "    mkfifo /dev/console"
	elog "    chmod 640 /dev/console"
	elog ""
	elog "Also configure your logger to log to /dev/console."
	echo
}
