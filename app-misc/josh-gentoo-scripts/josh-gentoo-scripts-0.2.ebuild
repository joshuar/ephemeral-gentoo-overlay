# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils perl-module

DESCRIPTION="A collection of random scripts that assist in the maintenance of a Gentoo Linux system"
HOMEPAGE="http://www.mso.anu.edu.au/~joshua"
SRC_URI="http://www.mso.anu.edu.au/~joshua/gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-portage/flagedit
app-portage/g-cpan
app-text/rcs
dev-perl/rcs-agent"

S="${WORKDIR}/josh-gentoo-scripts"

src_compile() {
	# 'compile' the Perl module
	cd "${S}"/JoshGentooScripts
	perl-module_src_prep
	perl-module_src_compile
}

src_install() {
	# install the scripts
	cd "${S}"
	newbin addpk.pl addpk
	newbin rempk.pl rempk
	newbin moduse.pl moduse
	# install the perl module
	cd "${S}"/JoshGentooScripts
	perl-module_src_install
}

pkg_postinst() {
	elog "You should *always* read the README file located at"
	elog "/usr/share/doc/${P}/README"
	elog "to find out what you have just installed and"
	elog "how it works."
	elog "When a new version is released, there are usually"
	elog "*always* significant changes to functionality."
	ewarn "You should back-up all files in /etc/portage"
	ewarn "before using any of these scripts."
}
