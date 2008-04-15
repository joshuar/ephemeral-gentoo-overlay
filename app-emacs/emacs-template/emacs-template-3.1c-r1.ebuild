# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

DESCRIPTION="Supplies an initial buffer content via a template: a file with normal text and expansion forms. "
HOMEPAGE="http://emacs-template.sourceforge.net/"
MY_P="template-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror"
DEPEND="virtual/emacs"

S="${WORKDIR}"/template

SITEFILE=50emacs-template.el

src_compile() {
	cd "${S}/lisp"
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file template.el
}

src_install() {
	elisp-install "${PN}" "${S}"/lisp/*.el "${S}"/lisp/*.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc README
	insinto /usr/share/doc/"${PF}"/templates
	doins "${S}"/templates/*
}

pkg_postinst() {
	elog "Example templates have been installed into:"
	elog "\t/usr/share/doc/${PF}/templates"
	elog "If you wish to use them, create ~/.templates"
	elog "and copy the ones you want into that directory."
}
