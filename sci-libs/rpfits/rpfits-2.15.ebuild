# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils fortran

DESCRIPTION="RPFITS is the data-recording format used within the Australia Telescope National Facility (ATNF)"
HOMEPAGE="http://www.atnf.csiro.au/computing/software/rpfits.html"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/rpfits/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror"

S=${WORKDIR}/rpfits

pkg_setup() {
		FORTRAN="gfortran"
		fortran_pkg_setup
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${PN}-makefile.patch

	# fix compiler(s) and compiler options
	sed -i \
		-e "s|FC.*|FC := $(tc-getFORTRAN)|g" \
		linux/GNUmakefile
	sed -i \
		-e "s|\$(CC)|$(tc-getCC)|g" \
	-e "s|\$(LD)|$(tc-getLD)|g" \
		GNUmakefile
}

src_compile() {
	cd "${S}/linux"
	# show the config
	emake show
	# now build
	emake || die "Make Failed!"
}

src_install() {
	cd "${S}/linux"

	dolib.a librpfits.a
#	 dolib.so librpfits.so
	dobin rpfex rpfhdr

	cd "${S}/code"
	insinto /usr/include
	doinc RPFITS.h rpfits.inc
}
