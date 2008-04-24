# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

MY_P="${PN}$(delete_all_version_separators ${PV})_src"

DESCRIPTION="Interactive FITS File Editor."
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/ftools/fv/"
SRC_URI="http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/${PN}/${MY_P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack "${A}"
	cd "${S}/tcltk/tcl/unix"
	epatch "${FILESDIR}/fv-5.1-notcldocs.patch"
	cd "${S}/tcltk/tk/unix"
	epatch "${FILESDIR}/fv-5.1-notkdemosdocs.patch"
}

src_compile() {
	cd "${S}/BUILD_DIR"
	econf --disable-register --prefix="${D}/usr/fv" || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	cd "${S}/BUILD_DIR"
	dodir /usr/fv
	emake -j1 install || die "Install failed"
}

pkg_postinst() {
	cd "${D}/usr/fv"
	local platform=$(ls -d *linux*)
	echo
	einfo "To use fv:"
	echo
	einfo "For users of C Shell variants (csh, tcsh):"
	echo
	einfo 'Edit your $HOME/.{t}cshrc to include the following lines:'
	einfo "    setenv HEADAS /usr/fv/${platform}"
	einfo '    alias heainit "source $HEADAS/headas-init.csh"'
	echo
	einfo "For users of Bourne Shell (sh, ash, ksh, and bash):"
	echo
	einfo 'Edit your $HOME/.bashrc to include the following lines:'
	einfo "    HEADAS=/usr/fv/${platform}"
	einfo "    export HEADAS"
	einfo '    alias heainit=". $HEADAS/headas-init.sh"'
	echo
	einfo "From then on, you can simply type 'heainit' when you log"
	einfo "on, and your environment will be prepared to use ${PN},"
	einfo "which can then be started with the command:"
	echo
	einfo "    fv"
}
