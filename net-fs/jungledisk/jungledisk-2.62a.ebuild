# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_PV="$(delete_all_version_separators)"

DESCRIPTION="Networked storage/backup using Amazon's S3 service."
HOMEPAGE="http://www.jungledisk.com"
SRC_URI_BASE="http://downloads.jungledisk.com/jungledisk"
SRC_URI="x86? ( ${SRC_URI_BASE}/${PN}${MY_PV}.tar.gz )
		 amd64? ( ${SRC_URI_BASE}/${PN}64-${MY_PV}.tar.gz ) "

LICENSE="jungledisk"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-fs/fuse"

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}"

src_install() {
	dodir /opt/jungledisk
	exeinto /opt/jungledisk
	doexe jungledisk junglediskmonitor
	dosym /opt/jungledisk/jungledisk /usr/bin/jungledisk
	dosym /opt/jungledisk/junglediskmonitor /usr/bin/junglediskmonitor
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/jungledisk.png"
	make_desktop_entry /usr/bin/junglediskmonitor "Jungle Disk Monitor" \
		/usr/share/pixmaps/jungledisk.png "Network; Utility"
	newdoc INSTALL README
}

pkg_postinst() {
	echo
	elog "- Your should read the README file which contains"
	elog "detailed instructions for using jungledisk."
	elog "- Also, check the release notes online:"
	elog "http://www.jungledisk.com/desktop/releasenotes.aspx"
	elog "- The built-in Automatic Backup feature currently "
	elog "only backs up normal files, however you can back up"
	elog "links, devices, and FIFOs using rsync directly with"
	elog "the mapped path."
	elog "- Jungle Disk attempts to locate your web browser"
	elog "automatically when clicking links in the software."
	elog "If it does not find your preferred web browser, simply"
	elog "create a symlink to your browser named "
	elog "~/.jungledisk/browser"
	echo
}
