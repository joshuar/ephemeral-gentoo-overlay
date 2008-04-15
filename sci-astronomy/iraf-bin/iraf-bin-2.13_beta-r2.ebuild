# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4
inherit eutils versionator distutils

DESCRIPTION="Image Reduction and Analysis Facility, a general purpose software system for the reduction and analysis of astronomical data."
HOMEPAGE="http://iraf.net/"

# versions/urls of all components
IRAFURL="http://iraf.net/ftp/iraf"
IRAFVER="V2.13-BETA"
STSDASURL="ftp://ftp.stsci.edu/pub/software/stsdas/"
STSDASVER="3.7"
STSDASOVER=$(delete_all_version_separators ${STSDASVER})
X11IRAFURL="${IRAFURL}/x11iraf"
X11IRAFVER="1.5DEV"
PYRAFVER="2.4"

# this could be cleaned up
SRC_URI="${IRAFURL}/${IRAFVER}/as.pcix.gen.gz
${IRAFURL}/${IRAFVER}/ib.rhux.x86.gz
${IRAFURL}/${IRAFVER}/nb.rhux.x86.gz
X? ( ${X11IRAFURL}/x11iraf-v${X11IRAFVER}-bin.redhat.tar.gz )
stsdas? ( ${STSDASURL}/tables_v${STSDASVER}/source/tables${STSDASOVER}.tar.gz
${STSDASURL}/tables_v${STSDASVER}/binaries/tables${STSDASOVER}.bin.redhat.tar.gz
${STSDASURL}/stsdas_v${STSDASVER}/source/stsdas${STSDASOVER}.tar.gz
${STSDASURL}/stsdas_v${STSDASVER}/binaries/stsdas${STSDASOVER}.bin.redhat.tar.gz )
pyraf? ( ftp://ra.stsci.edu/pub/pyraf/v${PYRAFVER}/stsci_python-${PYRAFVER}.tar.gz )"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="X stsdas pyraf"
DEPEND="app-shells/tcsh
sys-libs/libtermcap-compat
pyraf? ( dev-lang/tk
dev-lang/tcl
dev-python/ipython
>=dev-python/numeric-24.2
dev-python/pmw
dev-python/urwid
dev-libs/libf2c
>=dev-python/numarray-1.5.2 )
X? ( x11-libs/libICE
x11-libs/libSM
x11-libs/libX11
x11-libs/libXext
x11-libs/libXmu
x11-libs/libXt )"
RDEPEND="${DEPEND}"

pkg_setup() {
	UNUSED_ARCHS="alpha cygwin freebsd generic hp700 irix linuxppc macosx macintel redhat rs6000 sparc ssol ssun sunos suse mc68020"
	HLIB_EXE="mkiraf mkmlist"
	CL_EXE="cl ecl"
	OTHER_EXE="generic mkpkg rmbin rmfiles rtar sgidispatch wtar rpp xpp xyacc xc"

	if use stsdas; then
		tables_srcpkg="tables$(delete_all_version_separators ${STSDASVER}).tar.gz"
		tables_binpkg="tables$(delete_all_version_separators ${STSDASVER}).bin.redhat.tar.gz"
		stsdas_srcpkg="stsdas$(delete_all_version_separators ${STSDASVER}).tar.gz"
		stsdas_binpkg="stsdas$(delete_all_version_separators ${STSDASVER}).bin.redhat.tar.gz"
	fi
	if use X; then
		x11iraf_pkg="x11iraf-v${X11IRAFVER}-bin.redhat.tar.gz"
	fi
	if use pyraf; then
		pyraf_pkg="stsci_python-${PYRAFVER}.tar.gz"
		# check for Tkinter support in python
		distutils_python_tkinter
		if ! use stsdas; then
			ewarn "You enabled the 'pyraf' USE flag, but not the"
			ewarn "'stsdas' USE flag.  PyRAF requires stsdas."
			ewarn "Please enable the 'stsdas' USE flag."
			die
		fi
	fi
}

src_unpack() {
	# unpack base iraf system
	einfo "Unpacking base IRAF files..."
	mkdir -p "${WORKDIR}"/iraf/iraf
	cd "${WORKDIR}"/iraf/iraf
	tar -zxf "${DISTDIR}"/as.pcix.gen.gz || die "Unpack as.pcix.gen.gz failed..."
	cd "${WORKDIR}"/iraf/iraf/unix/bin.redhat/
	mv * ../bin.linux/

	mkdir -p "${WORKDIR}"/iraf/irafbin/bin.linux
	cd "${WORKDIR}"/iraf/irafbin/bin.linux
	tar -zxpf "${DISTDIR}"/ib.rhux.x86.gz || die "Unpack ib.rhux.x86.gz failed..."

	mkdir -p "${WORKDIR}"/iraf/irafbin/noao.bin.linux
	cd "${WORKDIR}"/iraf/irafbin/noao.bin.linux
	tar -zxpf "${DISTDIR}"/nb.rhux.x86.gz || die "Unpack nb.rhux.x86.gz failed..."

	# unpack X11IRAF
	if use X; then
		einfo "Unpacking X11IRAF..."
		mkdir -p "${WORKDIR}"/iraf/x11iraf/
		cd "${WORKDIR}"/iraf/x11iraf/
		unpack ${x11iraf_pkg}
	fi

	# unpack STSDAS
	if use stsdas; then
		einfo "Unpacking STSDAS..."
		mkdir -p "${WORKDIR}"/iraf/extern/tables/bin.linux
		cd "${WORKDIR}"/iraf/extern/tables/
		unpack ${tables_srcpkg} || die "Unpack ${tables_srcpkg} failed..."
		cd "${WORKDIR}"/iraf/extern/tables/bin.linux
		unpack ${tables_binpkg} || die "Unpack ${tables_binpkg} failed..."

		mkdir -p "${WORKDIR}"/iraf/extern/stsdas/bin.linux
		cd "${WORKDIR}"/iraf/extern/stsdas
		unpack ${stsdas_srcpkg} || die "Unpack ${stsdas_srcpkg} failed..."
		cd "${WORKDIR}"/iraf/extern/stsdas/bin.linux
		unpack ${stsdas_binpkg} || die "Unpack ${stsdas_binpkg} failed..."
	fi

	# unpack PyRAF
	if use pyraf; then
		einfo "Unpacking PyRAF..."
		cd "${WORKDIR}"
		unpack ${pyraf_pkg} || die "Unpack ${pyraf_pkg} failed."
	fi
}

src_compile() {
	if use stsdas; then
		# byte-compile python libraries, better ebuild way to do this?
		einfo "Compiling STSDAS Python components..."
		cd "${WORKDIR}"/iraf/extern/stsdas
		${python} "${WORKDIR}"/iraf/extern/stsdas/python/compileall.py "${WORKDIR}"/iraf/extern/stsdas/python
		${python} "${WORKDIR}"/iraf/extern/stsdas/python/compileall.py "${WORKDIR}"/iraf/extern/stsdas/python/*
	fi

	if use pyraf; then
		einfo "Compiling PyRAF (STSCI-Python)..."
		cd "${WORKDIR}"/stsci_python-${PYRAFVER}
		distutils_src_compile
	fi
}

pkg_preinst() {
	# create the iraf user/group
	einfo "Creating iraf user and group..."
	enewgroup iraf
	enewuser iraf -1 "/bin/csh" "/iraf/iraf/local" "iraf,users,wheel" || die "Problem adding iraf user"
}

src_install() {
	# install base files
	einfo "Installing base IRAF files..."
	dodir /iraf
	cd "${WORKDIR}"/iraf
	cp -pPR iraf irafbin "${D}"/iraf/

	# simulate the install script
	einfo "Installing IRAF tasks into the system..."

	dosym "${D}"/iraf/iraf/unix/hlib/libc/iraf.h /usr/include/iraf.h
	for task in ${HLIB_EXE}; do
		dosym "${D}"/iraf/iraf/unix/hlib/${task}.csh /usr/bin/${task}
	done
	for task in ${CL_EXE}; do
		dosym "${D}"/iraf/irafbin/bin.linux/${task}.e /usr/bin/${task}
	done
	for task in ${OTHER_EXE}; do
		dosym "${D}"/iraf/iraf/unix/bin.linux/${task}.e /usr/bin/${task}
	done

	if [ -h "${D}"/iraf/iraf/bin ]; then
		rm -f "${D}"/iraf/iraf/bin
	fi
	ln -sf "${D}"/iraf/irafbin/bin.linux "${D}"/iraf/iraf/bin

	einfo "Marking update time..."
	touch "${D}"/iraf/iraf/unix/hlib/utime

	# x11iraf install
	if use X; then
		einfo "Installing X11IRAF..."
		cd "${WORKDIR}"/iraf/x11iraf
		dolib lib.redhat/*
		dobin bin.redhat/*
		insinto /usr/include
		doins include/*
		doman man/*
		insinto /usr/share/X11/app-defaults
		doins app-defaults/*
		make_desktop_entry "xgterm" "xgterm" "xterm.png" "Application;Utility;TerminalEmulator"
	fi

	# stsdas install
	if use stsdas; then
		einfo "Installing STSDAS..."
		dodir /iraf/extern/
		cd "${WORKDIR}"/iraf/extern
		cp -pPR * "${D}"/iraf/extern/
		for pkg in stsdas tables; do
			if [ -h "${D}/iraf/extern/${pkg}/bin" ]; then
				rm -f "${D}/iraf/extern/${pkg}/bin"
			fi
			ln -sf "${D}/iraf/extern/${pkg}/bin.linux" "${D}/iraf/extern/${pkg}/bin"
		done
	fi

	# pyraf install
	if use pyraf; then
		einfo "Installing PyRAF..."
		cd "${WORKDIR}"/stsci_python-${PYRAFVER}
		distutils_src_install
	fi

	# remove extra arch dirs
	einfo "Removing extra arch-specific files..."
	for arch in ${UNUSED_ARCHS}; do
		for type in bin as scidata; do
			find "${D}" -type d -name "${type}.${arch}" -exec rm -fr "{}" \;
		done
	done

	# change permissions on iraf directory tree
	einfo "Adjusting permissions in IRAF directory tree..."
	chown -R iraf:iraf "${D}"/iraf
	find "${D}/iraf" -name "*.e" -exec chmod a+rx "{}" \;
	chown 0 "${D}/iraf/iraf/unix/bin.linux/alloc.e"
	chmod u+s "${D}/iraf/iraf/unix/bin.linux/alloc.e"

	# create required pipes in /dev
	einfo "Creating fifo pipes for image display..."
	for pipe in imt1i imt1o; do
		if [ ! -e /dev/${pipe} ]; then
			dodir /dev
			mkfifo "${D}"dev/${pipe}
			chmod 777 "${D}"dev/${pipe}
		fi
	done
	if [ ! -e /dev/imt1 ]; then
		dosym /dev/imt1o /dev/imt1
	fi
}

pkg_postinst() {
	elog ""
	elog "This ebuild does not enable IRAF networking."
	elog ""
	elog "IRAF Networking can be used to access a remote image, tape device,"
	elog "display server, or other network service. It's configuration is not"
	elog "a requirement for normal IRAF operations and it can be updated at any"
	elog "time by editing the IRAF dev$hosts file with new entries."
	elog ""
	elog "To begin using IRAF simply log in as any user and from the"
	elog "directory you wish to use as your iraf login directory type:"
	elog "			% mkiraf        # create a login.cl file"
	elog "			% cl            # start IRAF"
	elog ""
	elog "The 'iraf' user is already configured with a login.cl file so a simple"
	elog "'cl' command is sufficient to start the system."
	elog ""
	elog "Additional information can be found at the IRAF.NET web site:"
	elog ""
	elog "					http://iraf.net"
	elog ""
	elog "Please contact http://iraf.net with any questions or problems."

}


