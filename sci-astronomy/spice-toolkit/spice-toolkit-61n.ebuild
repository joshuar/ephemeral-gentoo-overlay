# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="An information system to assist scientists in planning and interpreting scientific observations from space-borne instruments."
HOMEPAGE="http://naif.jpl.nasa.gov/naif/toolkit.html"
MY_PN="cspice"
SRC_URI="ftp://naif.jpl.nasa.gov/pub/naif/toolkit//C/PC_Linux_C/packages/${MY_PN}.tar.Z"

LICENSE="as-is"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPENDS="app-shells/tcsh"
RDEPENDS="${DEPENDS}"

S="${WORKDIR}/cspice"

src_unpack() {
	unpack "${A}"
	cd "${S}/src/cspice"
	# patch to build shared cspice lib
	epatch "${FILESDIR}/${PN}-cspicesharedlib.patch"
	cd "${S}/src/csupport"
	# patch to build shared csupport lib
	epatch "${FILESDIR}/${PN}-csupportsharedlib.patch"
}

src_compile() {
	cd "${S}"
	# Set compiler options and compile using provided script
	TKCOMPILER="$(tc-getCC)" \
		TKCOMPILEOPTIONS="-c -ansi ${CFLAGS} -fPIC -DNON_UNIX_STDIO" \
		TKLINKER="$(tc-getLD)" \
		TKLINKOPTIONS="${LDFLAGS} -lm" \
		csh -f makeall.csh
}

src_install() {
	# install documentation
	cd "${S}/doc"
	dodoc *
	# install binaries
	cd "${S}/exe"
	dobin *
	# install header files
	cd "${S}/include"
	insinto "/usr/include"
	doins *
	# install libraries
	cd "${S}/lib"
	dolib lib*
}
