# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="Scisoft is a project within ESO to provide a collection of astronomical software utilities in a uniform way at all four ESO sites and to make them available to the outside world."
HOMEPAGE="http://www.eso.org/sci/data-processing/software/scisoft$(get_major_version)/"
MY_PN="scisoft"
SRC_URI="ftp://ftp.eso.org/${MY_PN}/${MY_PN}$(get_major_version)/linux/fedora6/tar/${MY_PN}-7.2.tar.gz"

LICENSE="as-is"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-db/unixODBC
dev-libs/libf2c
media-libs/sdl-image
media-libs/sdl-ttf"

S="${WORKDIR}"

src_unpack() {
	einfo "    Unpacking large source file. This will take some time..."
	unpack "${A}"
}

src_compile() {
	einfo "    This is a binary package, no compilation done."
}

src_install() {
	# plain cp is used in places because
	# there are lots of symlinks in the
	# scisoft tree that doexe, doins etc.
	# do not handle and could cause
	# breakage if not maintained

	einfo "    Intalling a lot of files, this will take some time..."
	einfo "    ...installing binaries, libraries etc."
	# install the base files
	dodir /scisoft
	cp -pPR "${S}/scisoft/"{bin,include,lib,info,man,share} "${D}scisoft"
	# install documentation
	einfo "    ...installing documentation"
	dodir "/usr/share/doc/${P}"
	cp -pPR "${S}/scisoft/doc/"* "${D}usr/share/doc/${P}"
	# install the misc. files needed
	einfo "    ...installing misc. files..."
	insinto /usr/local/include
	doins "${S}"/usr/include/iraf.h
	insinto /usr/local/lib
	doins "${S}"/usr/local/lib/imtoolrc

	# finish up
	prepalldocs
}

pkg_postinst() {
	elog "Using the ESO Scientific Software Collection (Scisoft)"
	echo
	elog "If the Scisoft software collection has been installed on your computer,"
	elog "or an accessible server machine it is essential for all users to"
	elog "source a shell script to configure their environment. What needs to"
	elog "be done depends on the user's shell:"
	echo
	elog "'csh' and 'tcsh' users should invoke the command:"
	echo
	elog "        source ${ROOT}scisoft/bin/Setup.csh"
	echo
	elog "and users of the 'bash' shell should use:"
	echo
	elog "        . ${ROOT}scisoft/bin/Setup.bash"
	echo
	elog "These commands may be conveniently added to an appropriate startup"
	elog "file such as .cshrc or .tcshrc (for csh and tcsh) and .profile (for bash)"
	elog "or the system-wide equivalents."
	echo
	elog "If you are unsure which shell you are using type:"
	echo
	elog "        echo $SHELL"
	echo
	elog "Once the setup script has been sourced all the Scisoft packages will be"
	elog "available without further action. So, for example you can start PyRAF"
	elog "by just typing 'pyraf'."
	echo
	elog "In order to use some applications within the Scisoft collection,"
	elog "you will need to create some devices under /dev.  This cannot be"
	elog "done via this ebuild."
	elog "Here are the commands you need to perform (as root):"
	echo
	elog "    mkfifo /dev/{imt1i,imt1o}"
	elog "    chmod 777 /dev/{imt1i,imt1o}"
	elog "    ln -s /dev/imt1o /dev/imt1"
	echo
	elog "Don't forget to manually delete these devices if you don't need"
	elog "them or are no longer using ${PN}."
}
