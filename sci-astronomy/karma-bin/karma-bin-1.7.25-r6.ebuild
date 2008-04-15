# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="karma"

DESCRIPTION="Toolkit for interprocess communications, authentication, encryption, graphics display, user interface and manipulating the Karma network data structure"
HOMEPAGE="http://www.atnf.csiro.au/computing/software/karma/"
URI_PREFIX="ftp://ftp.atnf.csiro.au/pub/software"
SRC_URI="${URI_PREFIX}/${MY_PN}/current/${MY_PN}.share-v${PV}.tar.gz
${URI_PREFIX}/${MY_PN}/current/i386_Linux_libc6.3-v${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc minimal examples"
RESTRICT="nomirror"

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	doc_root="/usr/share/doc/${P}"
	html_root="${doc_root}/html"
	gui_apps="kvis kshell kpvslice koords kmodel-shell kmodel-spiral kpolar kscale kslice_3d kstopper xray"
}

src_compile() {
	einfo "Binary package, no compilation necessary"
	return 0
}

src_install() {
	# remove MultibeamView
	# requires non-existant library
	rm -f "${S}"/bin/MultibeamView

	# the convert command conflicts with
	# media-gfx/imagemagick's convert
	# install it under a different name
	newbin "${S}"/bin/convert karma-convert
	rm -f "${S}"/bin/convert
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
	doicon "${FILESDIR}"/karma.png
	for app in ${gui_apps}; do
		make_desktop_entry ${app} $(capitalize_ichar ${app}) karma.png "Astronomy;Science"
	done
}


function capitalize_ichar {
	string="$1"
	firstchar=${string:0:1}
	string1=${string:1}
	FirstChar=`echo "$firstchar" | tr a-z A-Z`
	echo "$FirstChar$string1"
}
