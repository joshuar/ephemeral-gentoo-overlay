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
IUSE="doc minimal examples"
RESTRICT="nomirror"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	doc_root="/usr/share/doc/${P}"
	html_root="${doc_root}/html"
}

src_compile() {
	return
}

src_install() {
	# remove MultibeamView
	# requires non-existant library
	rm -f "${S}"/bin/MultibeamView

	# install binaries and libraries
	dobin "${S}"/bin/*
	dolib "${S}"/lib/*

	# install include files
	dodir /usr/include/"${MY_PN}"
	insinto /usr/include/"${MY_PN}"
	doins -r "${S}"/include/*

	# install shared files
	dodir /usr/"${MY_PN}"/share
	insinto /usr/"${MY_PN}"/share
	doins "${S}"/share/*

	# install devel scripts
	if ! use minimal ; then
		dodir /usr/lib/"${MY_PN}"/bin
		exeinto /usr/lib/"${MY_PN}"/bin
		doexe "${S}"/csh_script/*
	fi

	# install man pages
	dodir /usr/share/man
	cp -pPR "${S}"/man/mann "${D}"/usr/share/man/
	if ! use minimal ; then
		cp -pPR "${S}"/man/man3 "${D}"/usr/share/man/
	fi

	# install docs
	dodir "${doc_root}"
	cp -pPR "${S}"/doc/* "${D}${doc_root}"
	cp -pPR "${S}"/Release* "${D}${doc_root}"
	if use doc ; then
		dodir "${html_root}"
		cp -pPR "${S}"/www/* "${D}${html_root}"
	fi

	# example scripts
	if use examples ; then
		dodir "${doc_root}"/examples
		insinto "${doc_root}"/examples
		doins "${S}"/cm_script/*
	fi

	# install desktop files
	doenvd "${FILESDIR}"/99karma
	make_desktop_entry kvis Kvis "${FILESDIR}"/karma-icon.png "Astronomy;Education;Science"
	make_desktop_entry kpvslice Kpvslice "${FILESDIR}"/karma-icon.png "Astronomy;Education;Science"
	make_desktop_entry kshell Kshell "${FILESDIR}"/karma-icon.png "Astronomy;Education;Science"
	make_desktop_entry xray Xray "${FILESDIR}"/karma-icon.png "Astronomy;Education;Science"
	make_desktop_entry koords Koords "${FILESDIR}"/karma-icon.png "Astronomy;Education;Science"
}
