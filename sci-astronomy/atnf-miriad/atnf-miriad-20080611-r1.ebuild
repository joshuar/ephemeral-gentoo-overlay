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
${UPDATES_URI}/mirupd-20070813-5.tar.gz
${UPDATES_URI}/mirupd-20080201-6.tar.gz
${UPDATES_URI}/mirupd-20080418-6.tar.gz
${UPDATES_URI}/mirupd-20080422-7.tar.gz
${UPDATES_URI}/mirupd-20080426-7.tar.gz
${UPDATES_URI}/mirupd-20080427-8.tar.gz
${UPDATES_URI}/mirupd-20080428-8.tar.gz
${UPDATES_URI}/mirupd-20080520-8.tar.gz
${UPDATES_URI}/mirupd-20080521-8.tar.gz
${UPDATES_URI}/mirupd-20080529-8.tar.gz
${UPDATES_URI}/mirupd-20080530-8.tar.gz
${UPDATES_URI}/mirupd-20080611-8.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="primaryuri"
IUSE="doc"

DEPEND="sci-libs/rpfits
sci-libs/pgplot
x11-libs/libX11
x11-libs/libXaw"
REPEND="${DEPEND}"

S="${WORKDIR}/miriad"

FORTRAN="gfortran"

src_unpack() {
	unpack miriad-{code,common}.tar.gz
	cd "${S}"
	for updatefile in ${DISTDIR}/mirupd-*; do
		uf=$(basename $updatefile)
		unpack "${uf}"
	done

	# fortran_src_unpack addition
	patch_fortran
	# use shared rpfits library if available
	epatch "${FILESDIR}/atnf-miriad-rpfits-shared-lib.patch"
	# only compile xpanel and xmtv spec tools
	sed -i 's|allsys :: sysdirs $(ALLSYSD)|allsys :: xmtv xpanel|' \
		"${S}/spec/GNUmakefile"

	cd "${S}"
	eautoreconf
}

src_compile() {
	# configure fails to find pgplot lib with this LDFLAG
	filter-ldflags -Wl,--as-needed --as-needed
	# From INSTALL.html
	# LFS not currently handled by configure but instead by
	# hard-coded C-preprocessor definitions in some of the specialized
	# GNUmakedefs.
	# If your operating system has LFS then you can add this manually
	# to your local GNUmakedefs.
	append-lfs-flags
	# be risky...
	replace-flags -O* -O3
	append-flags -fPIC -funroll-loops
	export FFLAGS="${FFLAGS} -O3 -fPIC -funroll-loops"

	cd "${S}"
	econf || die "econf failed"
	emake MIR=${S} \
		MAKEMODE="system" \
		ALLSYSD="tools inc linpack subs prog spec" \
		COPT="${CFLAGS}"  \
		FCOPT="${FFLAGS}" \
		CPPOPT="${CPPFLAGS}" \
		LDOPT="${LDFLAGS}" -j1 \
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
	doenvd ${FILESDIR}/99miriad
}
