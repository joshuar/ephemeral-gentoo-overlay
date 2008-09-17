# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package font

MY_P="tg-v${PV}"

DESCRIPTION="Fonts extending freely available URW fonts."
HOMEPAGE="http://www.gust.org.pl/projects/e-foundry/tex-gyre"
SRC_URI="${HOMEPAGE}/whole/${MY_P}.zip"
LICENSE="GUST-FONT-LICENSE"

SLOT="0"
KEYWORDS="x86"
IUSE="+latex"

RESTRICT="nomirror"

S="${WORKDIR}/${MY_P}"
SUPPLIER="public"
FONT_S="${S}/fonts/opentype/public/${PN}"
FONT_SUFFIX="otf"

pkg_setup() {
	font_pkg_setup
}

src_install() {
	# install fonts for latex
	if use latex; then
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
		cd "${S}/tex/latex/tex-gyre"
		latex-package_src_doinstall all

		cd "${S}/doc/fonts/tex-gyre"
		dodoc * || die "dodoc failed"

		if latex-package_has_tetex_3; then
			insinto /etc/texmf/updmap.d
			doins "${FILESDIR}/${PN}.cfg"
		fi
	fi

	# install fonts for X11
	font_src_install
}

pkg_postinst() {
	if use latex; then
		latex-package_pkg_postinst
	fi
	font_pkg_postinst
	elog ""
	elog "You can use the ${PN} fonts in X applications"
	elog "by adding:"
	elog "    /usr/share/fonts/tex-gyre"
	elog "as a FontPath in your Xorg configuration file."
	elog ""
	elog "In a running X session and if you have"
	elog "x11-apps/xset installed, you can type:"
	elog "    xset +fp /usr/share/fonts/tex-gyre"
	elog "To use the fonts straight away."
}


pkg_postrm() {
	latex-package_pkg_postrm
	font_pkg_postrm
}
