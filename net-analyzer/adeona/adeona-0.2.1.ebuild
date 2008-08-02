# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="System for tracking the location of your lost or stolen laptop."
HOMEPAGE="http://adeona.cs.washington.edu/"
SRC_URI="${P}.tar.gz"

LICENSE="adeona"
SLOT="0"
KEYWORDS="~x86"
IUSE="wifi"

DEPEND="dev-libs/openssl
		net-analyzer/traceroute"
RDEPEND="${DEPEND}
		 wifi? ( net-wireless/wireless-tools )"

RESTRICT="fetch"

S="${WORKDIR}/${PN}"

pkg_nofetch() {
		einfo "Please download tar.gz source from:"
		einfo "http://adeona.cs.washington.edu/sourcedownload.html"
		einfo "Then put the file in ${DISTDIR}/${SRC_URI}"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i \
		-e "s|GCC := .*|GCC := $(tc-getCC)|" \
		-e "s|CFLAGS :=.*|CFLAGS := ${CFLAGS}|" \
		-e "s|LIBS :=.*|LIBS := -lm $(pkg-config --libs openssl) ${LDFLAGS}|" \
		Makefile
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	cd "${S}"
	dosbin *.exe
	insinto /etc/${PN}
	doins resources/*.adeona
	dodoc Readme.txt
	dodir /var/{lib,log}/${PN}
	doinitd "${FILESDIR}"/adeona
}

pkg_config() {
	local statedir="${ROOT}"/var/lib/adeona
	if [ ! -e "${statedir}"/adeona-clientstate.cst ]; then
		einfo "To protect your location-finding credentials, please"
		einfo "pick a password for Adeona. It does not need to be "
		einfo "the same as your login password."
		cd "${statedir}"
		/usr/sbin/adeona-init.exe -r /etc/adeona -l /var/log/adeona
	fi
	if [ $? == 0 ]; then
		einfo "Adeona successfully initialised.  You should now"
		einfo "start adeona with the command:"
		einfo "/etc/init.d/adeona start"
		einfo "Add this init script to your boot runlevel."
		echo
		elog  "You should store the file:"
		elog  "${statedir}/adeona-retrievecredentials.ost"
		elog  "in a safe place. You will need it to use the"
		elog  "information retrieval features of adeona."
	else
		einfo "Adeona could not be initialized. Please make sure"
		einfo "you gave a password. If you are having trouble, "
		einfo "try deleting the contents of ${statedir} and manually"
		einfo "run:"
		einfo "/usr/sbin/adeona-init.exe -r /etc/adeona -l /var/log/adeona"
	fi
}

