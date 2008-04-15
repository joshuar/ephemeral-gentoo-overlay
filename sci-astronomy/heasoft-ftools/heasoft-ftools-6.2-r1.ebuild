# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs fortran

DESCRIPTION="Generic HEASOFT tools for manipulating FITS files."
HOMEPAGE="http://heasarc.gsfc.nasa.gov/lheasoft/ftools/"
MY_P="heasoft${PV}src.tar.gz"
SRC_URI=${MY_P}
DOWNLOAD_URL="http://heasarc.gsfc.nasa.gov/cgi-bin/Tools/tarit/tarit.pl?mode=download&arch=src&checkallgeneral=on&general=caltools&general=futils&general=fimage&general=heasarc&general=heatools&general=guis&general=timepkg"

RESTRICT="nomirror fetch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

S=${WORKDIR}/headas-${PV}



pkg_nofetch() {
	elog "Please download heasoft using the following command (as root):"
	elog "#wget -O ${DISTDIR}/heasoft${PV}src.tar.gz \"${DOWNLOAD_URL}\""
	elog "and then re-emerge this package."
}

pkg_setup() {
		FORTRAN="g77"
		fortran_pkg_setup
}

src_unpack() {
	unpack "${A}"
	cd "${S}/BUILD_DIR"
	# patch hd_register.sh to not send mail (sneeky sneeky)
	epatch ${FILESDIR}/${PN}-hd_register-nomail.patch
	for component in tk tcl
	do
	cd "${S}/tcltk/${component}/unix"
	epatch ${FILESDIR}/${PN}-${component}makefile.patch
	done
	for component in itk tix itcl iwidgets
	do
	cd "${S}/tcltk/${component}"
	epatch ${FILESDIR}/${PN}-${component}makefile.patch
	done
}

src_compile() {
	cd "${S}/BUILD_DIR"
	econf CC=$(tc-getCC) CXX=$(tc-getCXX) || die "econf failed"
	emake
#	 emake install
}

src_install() {
	cd ${D}
}

