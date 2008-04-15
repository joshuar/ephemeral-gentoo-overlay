# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic fortran toolchain-funcs

BASE_URI="ftp://ftp.atnf.csiro.au/pub/software/miriad"
UPDATES_URI="${BASE_URI}/updates"
DESCRIPTION="Radio interferometry data reduction package"
HOMEPAGE="http://www.atnf.csiro.au/computing/software/miriad/"
SRC_URI="${BASE_URI}/miriad-code.tar.gz
${BASE_URI}/miriad-common.tar.gz
${UPDATES_URI}/mirupd-20070125-6.tar.gz
${UPDATES_URI}/mirupd-20070323-6.tar.gz
${UPDATES_URI}/mirupd-20070523-6.tar.gz
${UPDATES_URI}/mirupd-20070813-6.tar.gz
${UPDATES_URI}/mirupd-20071024-7.tar.gz
${UPDATES_URI}/mirupd-20071101-7.tar.gz
${UPDATES_URI}/mirupd-20071129-7.tar.gz
${UPDATES_URI}/mirupd-20080201-7.tar.gz
${UPDATES_URI}/mirupd-20080202-8.tar.gz
${UPDATES_URI}/mirupd-20080213-8.tar.gz
${UPDATES_URI}/mirupd-20080225-8.tar.gz
${UPDATES_URI}/mirupd-20080303-8.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nomirror"
IUSE="doc"

DEPEND="sci-libs/rpfits
sci-libs/pgplot
x11-libs/libX11
x11-libs/libXaw"
REPEND="${DEPEND}"

S="${WORKDIR}/miriad"

FORTRAN="gfortran"

src_unpack() {
	fortran_src_unpack "${A}"

	# use shared rpfits library if available
	cd "${S}"
	epatch "${FILESDIR}/atnf-miriad-rpfits-shared-lib.patch"
	# Patch array sizes
	cd "${S}/inc"
	epatch "${FILESDIR}/${PN}-arraysizes.patch"
	# Apply patch kludges to spec tools
	cd "${S}/spec/xpanel"
	epatch "${FILESDIR}/${PN}-xpanel-makefile.patch"
	cd "${S}/spec/xmtv"
	epatch "${FILESDIR}/${PN}-xmtv-makefile.patch"
	cd "${S}/spec/sxmtv"
	epatch "${FILESDIR}/${PN}-sxmtv-makefile.patch"

	cd "${S}"
	eautoreconf
}

src_compile() {
	# configure fails to find pgplot lib with this LDFLAG
	filter-ldflags '-Wl,--as-needed'

	cd "${S}"
	econf || die "econf failed"
	emake MIR=${S} \
		COPT="${CFLAGS} -fPIC"  \
		FCOPT="${FFLAGS} -fPIC" -j1 \
		|| die "emake failed"
}

src_install() {
	cd "${S}"
	exeinto /usr/miriad/bin
	doexe linux/bin/*
	insinto /usr/miriad/lib
	doins linux/lib/*
	for mandir in man/man?; do
		doman ${mandir}/*
	done
	insinto /usr/miriad/cat
	doins -r cat/*
	insinto /usr/miriad/inc
	doins inc/*.{h,inc}
	dodoc VERSION DISCLAIMER progguide.ps userguide.ps
	insinto "/usr/share/doc/${PF}/specdoc"
	doins specdoc/*
	if use doc; then
		insinto "/usr/share/doc/${PF}"
		doins -r html/*
	fi
	doenvd ${FILESDIR}/99miriad
	# record the date for keeping track of the last update
	echo `date '+%Y%m%d'` >> "${D}/${UPDATEFILE}"
}
