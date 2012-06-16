# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=4

inherit pam eutils multilib toolchain-funcs

DESCRIPTION="Password strength checking for PAM aware password changing programs"
HOMEPAGE="http://www.openwall.com/passwdqc/"
SRC_URI="http://www.openwall.com/passwdqc/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pam"

DEPEND="pam? ( virtual/pam )
		!sys-auth/pam_passwdqc"

src_compile() {
	make_tgt='utils'
	use pam && make_tgt="pam ${make_tgt}"
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		LDFLAGS_shared_LINUX="--shared ${LDFLAGS}" \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		${make_tgt} || die "emake failed"
}

src_install() {
	if use pam; then
		emake DESTDIR="${D}" \
			SECUREDIR="/$(get_libdir)/security" \
			install_pam || die "emake install_pam failed"
	fi
	emake DESTDIR="${D}" \
		SHARED_LIBDIR="/$(get_libdir)" \
		install_lib install_utils \
		|| die "emake install_lib install_utils failed"
	dodoc INTERNALS README
}

pkg_postinst() {
	if use pam; then
		elog
		elog "To activate pam_passwdqc use pam_passwdqc.so instead"
		elog "of pam_cracklib.so in /etc/pam.d/system-auth."
		elog "Also, if you want to change the parameters, read up"
		elog "on the pam_passwdqc(8) man page."
		elog
	fi
}
