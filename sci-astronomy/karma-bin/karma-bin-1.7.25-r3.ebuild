# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="karma"

DESCRIPTION="Toolkit for interprocess communications, authentication, encryption, graphics display, user interface and manipulating the Karma network data structure"
HOMEPAGE="http://www.atnf.csiro.au/computing/software/karma/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${MY_PN}/current/${MY_PN}.share-v${PV}.tar.gz ftp://ftp.atnf.csiro.au/pub/software/${MY_PN}/current/i386_Linux_libc6.3-v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
RESTRICT="nomirror"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	install_root="/karma"
	doc_root="/usr/share/doc/${P}"
	html_root="${doc_root}/html"
}

src_compile() {
	return
}

src_install() {
	# define install paths
	dodir "${install_root}"
	dodir "${doc_root}"

	# remove MultibeamView
	# requires non-existant library
	rm -f "${S}/bin/MultibeamView"

	# install files
	for dir in bin cm_script csh_script include lib share
	do
		cp -pPR "${S}/${dir}" "${D}${install_root}/"
	done

	# install man pages
	dodir "/usr/share/"
	cp -pPR "${S}/man" "${D}/usr/share/"

	# install docs
	cp -pPR "${S}/doc" "${D}${doc_root}"
	cp -pPR "${S}/Release"* "${D}${doc_root}"
	if use doc ; then
		dodir "${html_root}"
		cp -pPR "${S}/www/"* "${D}${html_root}"
	fi

	# prep docs
	prepalldocs

	# install environment file
	doenvd ${FILESDIR}/99karma
	make_desktop_entry kvis Kvis ${FILESDIR}/karma-icon.png Astronomy,Education,Science
	make_desktop_entry kpvslice Kpvslice ${FILESDIR}/karma-icon.png Astronomy,Education,Science
	make_desktop_entry kshell Kshell ${FILESDIR}/karma-icon.png Astronomy,Education,Science
	make_desktop_entry xray Xray ${FILESDIR}/karma-icon.png Astronomy,Education,Science
	make_desktop_entry koords Koords ${FILESDIR}/karma-icon.png Astronomy,Education,Science
}
