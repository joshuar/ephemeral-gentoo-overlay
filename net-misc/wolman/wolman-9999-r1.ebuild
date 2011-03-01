# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4-r2 git eutils

QT4_BUILT_WITH_USE_CHECK="png"

EGIT_REPO_URI="git://git.dolezel.info/wolman.git"
DESCRIPTION="GUI Wake-on-LAN manager"
HOMEPAGE="http://www.dolezel.info/projects/wolman"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="suid"

DEPEND="x11-libs/qt-gui:4
	net-libs/libnet
	net-libs/libpcap"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

S="${WORKDIR}/${PN}"

src_install() {
	dosbin ${PN} || die "dosbin failed"
	use suid && fperms u+s "/usr/sbin/${PN}"
}
