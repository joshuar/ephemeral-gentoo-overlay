# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

DESCRIPTION="Scisoft is a project within ESO to provide a collection of astronomical software utilities in a uniform way at all four ESO sites and to make them available to the outside world."
HOMEPAGE="http://www.eso.org/sci/data-processing/software/scisoft$(get_major_version)/"
MY_PN="scisoft"
SRC_URI="ftp://ftp.eso.org/${MY_PN}/${MY_PN}$(get_major_version)/linux/fedora6/tar/${MY_PN}-${PV}.tar.gz"

LICENSE="as-is"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-db/unixODBC
dev-libs/libf2c
media-libs/sdl-image
media-libs/sdl-ttf"

pkg_setup() {
	DOCS="ChangeLog CONTENTS README README_USERS RELEASE_NOTES VERSION"
	INSTALLDIRS="bin doc include info lib man share"
}

src_unpack() {
	einfo "    Unpacking large source file. This will take some time..."
	unpack "${A}"
}

src_compile() {
	einfo "    This is a binary package, no compilation done."
}

src_install() {
	cd "${WORKDIR}"/scisoft

	# Install the base files
	dodir /scisoft
	cp -pPR ${INSTALLDIRS} "${D}scisoft"

	# Install the misc. files needed
	insinto /usr/local/include
	doins "${WORKDIR}"/usr/include/iraf.h
	insinto /usr/local/lib
	doins "${WORKDIR}"/usr/local/lib/imtoolrc
	for pipe in imt1i imt1o
	do
		if [ ! -e /dev/${pipe} ]; then
			dodir /dev
			mkfifo "${D}"dev/${pipe}
			chmod 777 "${D}"dev/${pipe}
		fi
	done
	if [ ! -e /dev/imt1 ]; then
		dosym /dev/imt1o /dev/imt1
	fi

	# Install the scisoft documentation
	cd "${WORKDIR}"/scisoft/doc/scisoft
	dodoc ${DOCS}
}

pkg_postinst() {
	elog "Using the ESO Scientific Software Collection (Scisoft)"
	elog
	elog "If the Scisoft software collection has been installed on your computer,"
	elog "or an accessible server machine it is essential for all users to"
	elog "source a shell script to configure their environment. What needs to"
	elog "be done depends on the user's shell:"
	elog
	elog "'csh' and 'tcsh' users should invoke the command:"
	elog
	elog "        source ${ROOT}scisoft/bin/Setup.csh"
	elog
	elog "and users of the 'bash' shell should use:"
	elog
	elog "        . ${ROOT}scisoft/bin/Setup.bash"
	elog
	elog "These commands may be conveniently added to an appropriate startup"
	elog "file such as .cshrc or .tcshrc (for csh and tcsh) and .profile (for bash)"
	elog "or the system-wide equivalents."
	elog ""
	elog "If you are unsure which shell you are using type:"
	elog
	elog "        echo $SHELL"
	elog
	elog "Once the setup script has been sourced all the Scisoft packages will be"
	elog "available without further action. So, for example you can start PyRAF"
	elog "by just typing 'pyraf'."
	elog ""
	elog "If you have difficulties please contact us."
	elog
	elog "The Scisoft Team, June 2007 (scihelp@eso.org)"

	ewarn "Note that there are a few name clashes that you should be aware of:"
	ewarn "The 'access' command, part of app-text/tetex clashes with a command with"
	ewarn "the same name in ${ROOT}scisoft/saord/bin.  You can get around this by"
	ewarn "making sure the scisoft program paths appear last in your PATH environment"
	ewarn "variable."
	ewarn "A further clash occurs with the 'co' command in app-text/rcs.  Again, you"
	ewarn "can adjust your PATH to overcome this issue."
}
