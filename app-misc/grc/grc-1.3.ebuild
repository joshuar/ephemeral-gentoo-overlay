# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/grc/grc-1.1.ebuild,v 1.5 2008/05/10 09:14:27 nixnut Exp $

inherit eutils

DESCRIPTION="Generic Colouriser is yet another colouriser for beautifying your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html"
SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cp -rf "${S}"{,.orig}
	cd "${S}"
	# epatch "${FILESDIR}"/1.0.6-support-more-files.patch
}

src_install() {
	insinto /usr/share/grc
	doins conf.* "${FILESDIR}"/conf.* || die "share files"
	insinto /etc
	doins grc.conf || die "conf"
	dobin grc grcat || die "dobin"
	dodoc README INSTALL TODO CHANGES CREDITS
	doman grc.1 grcat.1
}
