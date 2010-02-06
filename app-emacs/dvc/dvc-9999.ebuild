# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools elisp bzr

DESCRIPTION="Common Emacs front-end for a number of distributed version control systems."
HOMEPAGE="http://download.gna.org/dvc/"
EBZR_REPO_URI="http://bzr.xsteve.at/dvc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	eautoreconf
}

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} lisp/*.{el,elc} \
		|| die "elisp-install failed."
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed."
	insinto ${SITEETC}/dvc
	doins texinfo/dvc.info || die "install info file failed."
	dodoc docs/*
}

pkg_postinst() {
	elisp-site-regen
	echo
	elog "To use dvc add:"
	elog "  (require 'dvc-autoloads)"
	elog "to your .emacs file."
	echo
}
