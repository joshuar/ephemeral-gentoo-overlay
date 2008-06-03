# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package font

MY_P="tg-v${PV}"

DESCRIPTION="TeX Fonts extending freely available URW fonts."
HOMEPAGE="http://www.gust.org.pl/projects/e-foundry/tex-gyre/"
SRC_URI="${HOMEPAGE}/whole/${MY_P}.zip"
LICENSE="GUST-FONT-LICENSE"

SLOT="0"
KEYWORDS="x86"
IUSE="X"

RDEPEND="!media-fonts/gyre-fonts"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_P}"
SUPPLIER="public"
FONT_S="${S}/fonts/opentype/public/${PN}"
FONT_SUFFIX="otf"

pkg_setup() {
	if use X; then
		font_pkg_setup
	fi
}

src_install() {
	for f in afm tfm type1; do
		cd "${S}/fonts/${f}/public/tex-gyre"
		latex-package_src_doinstall fonts
	done

	for f in enc map; do
		cd "${S}/fonts/${f}/dvips/${PN}"
		insinto "${TEXMF}/fonts/${f}/dvips/${PN}"
		doins * || die "doins ${f} failed"
	done

	cd "${FONT_S}"
	insinto "${TEXMF}/fonts/opentype/${SUPPLIER}/${PN}"
	doins * || die "doins opentype fonts failed"

	if use X; then
		font_src_install
	fi

	cd "${S}/tex/latex/tex-gyre"
	latex-package_src_doinstall all

	cd "${S}/doc/fonts/tex-gyre"
	dodoc *.pdf README*
}

pkg_postinst() {
	latex-package_pkg_postinst

	if use X; then
		font_pkg_postinst
		elog ""
		elog "You can use the ${PN} fonts in X applications"
		elog "by adding:"
		elog "    /usr/share/fonts/tex-gyre"
		elog "as a FontPath in your Xorg configuration file."
		elog ""
		elog "In a running X session try:"
		elog "    xset +fp /usr/share/fonts/tex-gyre"
		elog ""
	fi
}


pkg_postrm() {
	latex-package_pkg_postrm

	if use X; then
		font_pkg_postrm
	fi
}
