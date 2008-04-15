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
RDEPEND="app-portage/g-cpan
app-text/rcs
dev-perl/rcs-agent"

S="${WORKDIR}"

pkg_setup() {
	DOCS="README VERSION"
}

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
	newsbin gentoo-updates.sh gentoo-updates
	newconfd gentoo-updates.conf gentoo-updates.conf
	# install the cron script
	exeinto /etc/cron.daily
	newexe gentoo-updates-cron.sh gentoo-updates
	# install the perl module
	cd "${S}"/JoshGentooScripts
	perl-module_src_install
}

pkg_postinst() {
	elog "A cron script has been installed to /etc/cron.daily/gentoo-udpates."
	elog "To enable it, edit /etc/cron.daily/gentoo-updates and follow the"
	elog "directions."
	elog ""
	elog "Further configuration of the gentoo-updates script can be found in:"
	elog "    /etc/conf.d/gentoo-updates.conf"
	elog ""
	elog "You should *always* read the README file located at"
	elog "/usr/share/doc/${P}/README"
	elog "to find out what you have just installed and"
	elog "how it works."
	elog "When a new version is released, there are usually"
	elog "*always* significant changes to functionality."
	elog ""
	ewarn "You should back-up all files in /etc/portage"
	ewarn "before using any of these scripts."
}
