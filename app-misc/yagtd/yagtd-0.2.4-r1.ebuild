# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit distutils elisp

DESCRIPTION="Console text todo list manager incorporating major features from Allen's 'Getting Things Done' philosophy and Stephen Covey's 'Seven Habits of Highly Effective People'."
HOMEPAGE="https://gna.org/projects/yagtd/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc emacs"

RESTRICT="nomirror"

pkg_setup() {
	if use emacs; then
		SITEFILE=50yagtd.el
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-noautodocs.patch"
}

src_compile(){
	distutils_src_compile
	if use emacs; then
		cd "${S}/tools"
		emacs --batch -f batch-byte-compile --no-site-file --no-init-file ${PN}-mode.el
	fi
}

src_install() {
	distutils_src_install
	dosym /usr/bin/yagtd.py /usr/bin/yagtd
	if use doc; then
		insinto /usr/share/doc/${P}/html
		doins doc/*
	fi
	if use emacs; then
		elisp-install "${PN}" "${S}"/tools/*.el "${S}"/tools/*.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}
