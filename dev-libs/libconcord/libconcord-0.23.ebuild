# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils perl-app

MY_PN="concordance"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library for programming Logitech Harmony universal remote controls"
HOMEPAGE="http://phildev.net/concordance/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+udev consolekit perl python"

DEPEND="dev-libs/libusb
		udev? ( sys-fs/udev )
		consolekit? ( sys-auth/consolekit )
		perl? ( virtual/perl-Module-Build
				dev-lang/swig )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/libconcord"

src_configure() {
	econf
}

src_compile() {
	emake || die

	if use consolekit; then
		emake consolekit || die
	elif use udev; then
		emake udev || die
	fi

	if use perl; then
		cd "${S}/bindings/perl"
		swig -perl5 concord.i
		perl-app_src_configure
	fi

	if use python; then
		cd "${S}/bindings/python"
		distutils_src_compile
	fi
}

src_install() {

	dodoc ../{Changelog,CodingStyle,TODO,SubmittingPatches} README
	insinto /usr/share/doc/${P}/specs
	doins ../specs/*

	emake DESTDIR="${D}" install || die

	if use consolekit; then
		emake DESTDIR="${D}" install_consolekit || die
	elif use udev; then
		emake DESTDIR="${D}" install_udev || die
	fi

	if use perl; then
		cd bindings/perl
		emake DESTDIR="${D}" install || die
	fi

	if use python; then
		cd "${S}/bindings/python"
		distutils_src_install
	fi
}
