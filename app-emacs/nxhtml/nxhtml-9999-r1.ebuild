# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils elisp bzr

DESCRIPTION="Emacs mode for editing XHTML, PHP and other web development technologies."
HOMEPAGE="http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html"
EBZR_REPO_URI="lp:nxhtml"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE=99${PN}-gentoo.el

src_compile() {
	find -type f -name '*~' -delete

	# this is complicated...
	cd ${S}/etc/schema
	elisp-compile schema-path-patch.el
	epatch ${FILESDIR}/${P}-schema-path-patch.patch
	rm -f schema-path-patch.elc
	elisp-compile schema-path-patch.el
	cd ${S}

	# phew, now this...
	elisp-compile autostart.el

	# ok, now just a few more...
	${EMACS} ${EMACSFLAGS} ${BYTECOMPFLAGS} \
		-l ${S}/autostart.elc -f batch-byte-compile *.el

	# and now, do the rest...
	for lispdir in alts nxhtml related util; do
		cd ${S}/${lispdir}
		find -type f -name '*.el' \
			-execdir ${EMACS} ${EMACSFLAGS} ${BYTECOMPFLAGS} \
			-l ${S}/autostart.elc -f batch-byte-compile "{}" \;
		cd ${S}
	done
}

src_install() {
	elisp-install ${PN} *.{el,elc} \
		|| die "elisp-install failed."
	for lispdir in alts nxhtml related util; do
		elisp-install ${PN}/${lispdir} ${lispdir}/*.{el,elc} \
			|| die "elisp-install failed."
	done
	insinto ${SITELISP}/${PN}
	doins -r etc || die

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	cd nxhtml
	for htmldir in html-{chklnk,toc,upl,wtoc}; do
		insinto ${SITEETC}/${PN}/${htmldir}
		doins -r ${htmldir}/* || die
	done
	cd ${S}

	dodoc README.txt nxhtml/ChangeLog
	insinto /usr/share/doc/${P}/html
	doins -r nxhtml/doc/*
}

pkg_postinst() {
	elisp-site-regen
	echo
	elog "To use ${PN} add:"
	elog '  (load "nxhtml/autostart.elc")'
	elog "to your .emacs file."
	echo
}
