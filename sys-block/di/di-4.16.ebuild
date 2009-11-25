# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-4.13.ebuild,v 1.5 2009/04/23 19:36:43 maekke Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND=""

src_compile() {
	tc-export CC
	export SHELL=/bin/bash
	local prefix="${D}"
	${SHELL} ./Build distclean \
		|| die "failed to distclean."
	${SHELL} ./Build \
		|| die "failed to build."
	cd po
	for i in *.po; do
		j=`echo $i | sed 's,\\.po$,,'`
		msgfmt -o $j.mo $i
	done
}

src_install() {
	doman di.1
	dobin di || die
	dosym di /usr/bin/mi
	dodoc README
	cd po
	for i in *.po; do
		j=`echo $i | sed 's,\\.po$,,'`;
		insinto /usr/share/locale/$j/LC_MESSAGES
		newins $j.mo di.mo
	done
}
