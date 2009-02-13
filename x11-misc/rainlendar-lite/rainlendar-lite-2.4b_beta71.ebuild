# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="Rainlendar"
MY_PV="2.4.b71"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Feature rich calendar application that is easy to use and doesn't take much space on your desktop."
HOMEPAGE="http://www.rainlendar.net"
SRC_URI="x86? ( http://www.rainlendar.net/download/${MY_P}-i386.tar.bz2 )
		 amd64? ( http://www.rainlendar.net/download/${MY_P}-amd64.tar.bz2 )"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-gtklibs
			app-emulation/emul-linux-x86-xlibs )
	x86? ( >=x11-libs/gtk+-2 )"

S=${WORKDIR}/rainlendar2

QA_TEXTRELS="opt/rainlendar2/plugins/iCalendarPlugin.so
opt/rainlendar2/plugins/NetworkPlugin.so
opt/rainlendar2/plugins/GooglePlugin.so"
QA_EXECSTACK="opt/rainlendar2/rainlendar2"

pkg_setup() {
	if use x86 && ! built_with_use '=x11-libs/gtk+-2*' xinerama ; then
		eerror "Please re-emerge x11-libs/gtk+ with the xinerama USE flag set" \
			&& die
	fi
}

src_install() {
	insinto /opt/rainlendar2
	doins -r locale plugins resources scripts skins rainlendar2.htb
	exeinto /opt/rainlendar2
	doexe rainlendar2
	dosym /opt/rainlendar2/rainlendar2 /usr/bin/rainlendar2
	dodoc Changes.txt
	doicon ${FILESDIR}/${PN}.png
	make_desktop_entry /opt/rainlendar2/rainlendar2 Rainlendar ${PN}.png 'Office;Calendar;GTK;'
}
