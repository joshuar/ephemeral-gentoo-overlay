# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils versionator

MY_PV="$(delete_all_version_separators)"

DESCRIPTION="Networked storage/backup using Amazon's S3 service."
HOMEPAGE="http://www.jungledisk.com"
SRC_URI_BASE="http://downloads.jungledisk.com/jungledisk/"
SRC_URI="x86? ( ${SRC_URI_BASE}/${PN}${MY_PV}.tar.gz )
		 amd64? ( ${SRC_URI_BASE}/${PN}64-${MY_PV}.tar.gz ) "

LICENSE="jungledisk-tos"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-fs/fuse"

RESTRICT="binchecks strip"

S="${WORKDIR}/${PN}"

# pkg_nofetch() {
# 	einfo "You need to sign up for a JungleDisk account before"
# 	einfo "using this software. Sign up here:"
# 	einfo
# 	einfo "  https://www.jungledisk.com"
# 	einfo
# 	einfo "Once you have an account, log in to your Jungledisk"
# 	einfo "account and download:"
# 	if use x86; then
# 		einfo "${SRC_URI_BASE}/${PN}${MY_PV}.tar.gz"
# 	fi
# 	if use amd64; then
# 		einfo "${SRC_URI_BASE}/${PN}64-${MY_PV}.tar.gz"
# 	fi
# 	einfo "and place the file in ${DISTDIR}"
# }

src_install() {
	exeinto /opt/${PN}
	doexe ${PN}
	dosym /opt/${PN}/${PN} /usr/bin/${PN}
	insinto /usr/share/pixmaps
	doins ${PN}.png
	make_desktop_entry /usr/bin/${PN} "Jungle Disk Desktop" \
		/usr/share/pixmaps/${PN}.png "Application;System;"
}

pkg_postinst() {
	echo
	elog "- You can view the release notes by logging into your"
	elog "Jungledisk account and navigating to:"
	elog "  https://www.jungledisk.com/downloads/personal/desktop/releasenotes.aspx"
	elog "- Jungle Disk attempts to locate your web browser"
	elog "automatically when clicking links in the software."
	elog "If it does not find your preferred web browser, simply"
	elog "create a symlink to your browser named "
	elog "~/.jungledisk/browser"
	echo
}
