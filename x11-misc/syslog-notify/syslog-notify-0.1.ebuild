# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="Provides real-time popup notification of system log messages via the freedesktop notification standard."
HOMEPAGE="http://jtniehof.github.com/syslog-notify/"
SRC_URI="http://cloud.github.com/downloads/jtniehof/syslog-notify/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="x11-libs/libnotify"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	make_desktop_entry syslog-notify "Syslog Notify" emblem-generic "Applications;System"
	dodoc AUTHORS README
}

pkg_postinst() {
	echo
	elog "syslog-notify needs a FIFO to receive the messages from syslog."
	elog "Create it with (as root):"
	elog ""
	elog "    mkfifo /var/spool/syslog-notify"
	elog ""
	elog "Then make it world-readable and writeable with:"
	elog "    chmod +rw /var/spool/syslog-notify"
	echo
}
