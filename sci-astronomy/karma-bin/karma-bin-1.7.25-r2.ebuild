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

src_unpack() {
	return
}

src_compile() {
	return
}

src_install() {
	# unpack and install
	dodir /opt
	cd "${D}/opt"
	for archive in ${A}
	do
		unpack "${archive}"
	done

	# remove MultibeamView
	# requires non-existant library
	rm -f "${D}/opt/karma/bin/MultibeamView"

	# define the install path
	local install_dir="${D}/opt/${MY_PN}"

	# install docs
	local docdir="/usr/share/doc/${PF}"
	dodir "${docdir}"
	mv -f "${install_dir}/doc/"* "${D}/${docdir}"
	mv -f "${install_dir}/Release"* "${D}/${docdir}"
	if use doc ; then
		local htmldoc_dir="${D}/${docdir}/html"
		mv -f "${install_dir}/www" "${htmldoc_dir}"
		# fix broken links
		for broken_link in update-policy README.lib
		do
			cd "${htmldoc_dir}"
			rm -f "${broken_link}"
			ln -sf "../${broken_link}" .
		done
		rm -f "${htmldoc_dir}/modules.html"
		cd "${htmldoc_dir}"
		ln -sf "../modules/Overview" .
	else
		rm -fr "${install_dir}/www"
	fi

	# prep docs
	prepalldocs

	# install environment file
	doenvd ${FILESDIR}/99karma
}

pkg_postinst() {
	elog "If you wish to keep karma up to date,"
	elog "set up a cron job as follows that executes:"
	elog "/opt/karma/csh_script/install-karma /opt/karma"
}
