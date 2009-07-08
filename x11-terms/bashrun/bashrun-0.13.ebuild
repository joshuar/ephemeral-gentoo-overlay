# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Provides a powerful application launcher by running a specialized bash session in a small terminal window"
HOMEPAGE="http://bashrun.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome kde"

DEPEND=""
RDEPEND="x11-misc/xdotool
		 gnome? ( gnome-extra/zenity )
		 kde? ( kde-base/kdialog )
		 x11-terms/xterm
		 x11-apps/xmessage
		 ${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	doman ${PN}.1
	insinto /usr/share/${PN}
	doins bashrc
}

pkg_postinst() {
	elog "Users upgrading from versions <= 0.6 will need to"
	elog "delete or rename their user configuration file due"
	elog "to substantial changes in the configuration file "
	elog "format and handling."
	echo
	elog "Users upgrading from versions >= 0.7, removing the"
	elog "configuration file is not strictly required, although"
	elog "it is recommended to easily add the new configuration"
	elog "options to your configuration file. Also, the default"
	elog "settings described in the manual page may differ from"
	elog "your configuration if you chose not to let bashrun "
	elog "recreate your configuration file."
}

