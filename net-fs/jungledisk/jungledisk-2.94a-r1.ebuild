# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils versionator

MY_PV="$(delete_all_version_separators)"

DESCRIPTION="Networked storage/backup using Amazon's S3 service."
HOMEPAGE="http://www.jungledisk.com"
SRC_URI_BASE="http://downloads.jungledisk.com/beta"
SRC_URI="x86? ( ${SRC_URI_BASE}/${PN}desktop${MY_PV}.tar.gz )
		 amd64? ( ${SRC_URI_BASE}/${PN}desktop64-${MY_PV}.tar.gz ) "

LICENSE="jungledisk"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/fuse"

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}desktop"

src_install() {
	local jdpath="/opt/${PN}"
	local jdfilename="junglediskdesktop"

	exeinto ${jdpath}
	doexe ${jdfilename}
	dosym ${jdpath}/${jdfilename} /usr/bin/${PN}

	doicon "${FILESDIR}/jungledisk.png"
	make_desktop_entry /usr/bin/${PN} "Jungle Disk Desktop" \
		jungledisk.png "Network;Utility;"
}

pkg_postinst() {
	echo
	elog "- Check the release notes online:"
	elog "http://www.jungledisk.com/desktop/betareleasenotes.aspx"
	elog "- Jungle Disk attempts to locate your web browser"
	elog "automatically when clicking links in the software."
	elog "If it does not find your preferred web browser, simply"
	elog "create a symlink to your browser named "
	elog "~/.jungledisk/browser"
	echo
}
