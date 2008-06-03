# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

MY_P="tg-v${PV}"

DESCRIPTION="Fonts extending freely available URW fonts (non-TeX versions)."
HOMEPAGE="http://www.gust.org.pl/projects/e-foundry/tex-gyre/"
SRC_URI="${HOMEPAGE}/whole/${MY_P}otf.zip"
LICENSE="GUST-FONT-LICENSE"

SLOT="0"
KEYWORDS="x86"
IUSE="X"

RDEPEND="!dev-tex/tex-gyre"

RESTRICT="nomirror"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="otf"
