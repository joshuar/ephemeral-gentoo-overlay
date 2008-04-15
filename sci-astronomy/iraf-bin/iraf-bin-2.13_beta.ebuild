# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Image Reduction and Analysis Facility, a general purpose software system for the reduction and analysis of astronomical data."
HOMEPAGE="http://iraf.net/"

# versions/urls of all components
IRAFURL="http://iraf.net/ftp/iraf"
IRAFVER="V2.13-BETA"
STSDASURL="ftp://ftp.stsci.edu/pub/software/stsdas/"
STSDASVER1="3.7"
STSDASVER2="37"
X11IRAFURL="${IRAFURL}/x11iraf"
X11IRAFVER="1.5DEV"

# this could be cleaned up
SRC_URI="${IRAFURL}/${IRAFVER}/as.pcix.gen.gz
${IRAFURL}/${IRAFVER}/ib.rhux.x86.gz
${IRAFURL}/${IRAFVER}/nb.rhux.x86.gz
X? ( ${X11IRAFURL}/x11iraf-v${X11IRAFVER}-bin.redhat.tar.gz )
stsdas? ( ${STSDASURL}/tables_v${STSDASVER1}/source/tables${STSDASVER2}.tar.gz
${STSDASURL}/tables_v${STSDASVER1}/binaries/tables${STSDASVER2}.bin.redhat.tar.gz
${STSDASURL}/stsdas_v${STSDASVER1}/source/stsdas${STSDASVER2}.tar.gz
${STSDASURL}/stsdas_v${STSDASVER1}/binaries/stsdas${STSDASVER2}.bin.redhat.tar.gz )"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE="X stsdas"
DEPEND="app-shells/tcsh
sys-libs/libtermcap-compat
stsdas? ( virtual/python )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use stsdas; then
		tables_srcpkg="tables${STSDASVER2}.tar.gz"
		tables_binpkg="tables${STSDASVER2}.bin.redhat.tar.gz"
		stsdas_srcpkg="stsdas${STSDASVER2}.tar.gz"
		stsdas_binpkg="stsdas${STSDASVER2}.bin.redhat.tar.gz"
	fi
	if use X; then
		x11iraf_pkg="x11iraf-v${X11IRAFVER}-bin.redhat.tar.gz"
	fi
}

src_unpack() {
	return 0
}

src_compile() {
	return 0
}

pkg_preinst() {
	# create the iraf user/group
	einfo "Creating iraf user and group..."
	enewgroup iraf
	enewuser iraf -1 "/bin/csh" "/iraf/iraf/local" "iraf,users,wheel" || die "Problem adding iraf user"
}

src_install() {
	# create directory structure
	einfo "Creating the IRAF directory tree..."
	dodir /iraf/iraf
	dodir /iraf/irafbin/bin.linux
	dodir /iraf/irafbin/noao.bin.linux
	dodir /iraf/x11iraf
	dodir /iraf/extern

	# unpack base iraf system
	einfo "Unpacking base IRAF files..."
	cd ${D}/iraf/iraf
	tar -zxf ${DISTDIR}/as.pcix.gen.gz || die "Unpack as.pcix.gen.gz failed..."
	cd ${D}/iraf/iraf/unix/bin.redhat/
	mv * ../bin.linux/

	cd ${D}/iraf/irafbin/bin.linux
	tar -zxpf ${DISTDIR}/ib.rhux.x86.gz || die "Unpack ib.rhux.x86.gz failed..."

	cd ${D}/iraf/irafbin/noao.bin.linux
	tar -zxpf ${DISTDIR}/nb.rhux.x86.gz || die "Unpack nb.rhux.x86.gz failed..."

	# simulate the install script
	einfo "Installing IRAF tasks..."

	dosym ${D}/iraf/iraf/unix/hlib/libc/iraf.h /usr/include/iraf.h
	for task in mkiraf mkmlist
	do
		dosym ${D}/iraf/iraf/unix/hlib/${task}.csh /usr/bin/${task}
	done

	for task in ecl cl
	do
		dosym ${D}/iraf/irafbin/bin.linux/${task}.e /usr/bin/${task}
	done

	for task in generic mkpkg rmbin rmfiles rtar sgidispatch wtar rpp xpp xyacc xc
	do
		dosym ${D}/iraf/iraf/unix/bin.linux/${task}.e /usr/bin/${task}
	done

	if [ -h "${D}/iraf/iraf/bin" ]; then
		rm -f "${D}/iraf/iraf/bin"
	fi
	ln -sf "${D}/iraf/irafbin/bin.linux" "${D}/iraf/iraf/bin"

	# remove other arch files
	einfo "Removing extra arch-specific files..."
	for arch in freebsd sunos cygwin linuxppc macosx macintel redhat suse sparc mc68020
	do
		item="${D}/iraf/iraf/bin.${arch}"
		if [ -e ${item} ] || [ -h ${item} ]; then
			einfo "     removing ${item}"
			rm -fr "${item}"
		fi
		for subdir in unix noao
		do
			for dtype in as bin
			do
				item="${D}/iraf/iraf/${subdir}/${dtype}.${arch}"
				if [ -e ${item} ] || [ -h ${item} ]; then
					einfo "     removing ${item}"
					rm -fr "${item}"
				fi
			done
		done
	done

	einfo "Marking update time..."
	touch ${D}/iraf/iraf/unix/hlib/utime

	# optional: x11iraf install
	if use X; then
		einfo "Installing X11IRAF..."
		cd ${D}/iraf/x11iraf/
		tar -zxf ${DISTDIR}/${x11iraf_pkg}
		mv lib.redhat lib.linux
		mv bin.redhat bin.linux
		for bin in obmsh resize vximtool xgterm ximtool ximtool-alt ximtool-old xtapemon
		do
			dosym ${D}/iraf/x11iraf/bin.linux/${bin} /usr/bin/${bin}
		done
		dosym ${D}/iraf/x11iraf/lib.linux/libcdl.a /usr/lib/libcdl.a
		for header in cdlftn.inc  cdl.h  cdlspp.h
		do
			dosym ${D}/iraf/x11iraf/include/${header} /usr/include/${header}
		done
		doman ${D}/iraf/x11iraf/man/*
		insinto /usr/share/X11/app-defaults
		doins ${D}/iraf/x11iraf/app-defaults/*
	fi

	# optional: stsdas install
	if use stsdas; then
		einfo "Installing STSDAS..."
		dodir /iraf/extern/tables
		dodir /iraf/extern/stsdas

		einfo "     Unpacking..."
		cd ${D}/iraf/extern/tables/
		tar -zxf ${DISTDIR}/${tables_srcpkg}

		cd ${D}/iraf/extern/tables/bin.linux
		tar -zxf ${DISTDIR}/${tables_binpkg}

		cd ${D}/iraf/extern/stsdas
		tar -zxf ${DISTDIR}/${stsdas_srcpkg}

		cd ${D}/iraf/extern/stsdas/bin.linux
		tar -zxf ${DISTDIR}/${stsdas_binpkg}

		# byte-compile python libraries, better ebuild way to do this?
		einfo "     Compiling..."
		cd ${D}/iraf/extern/stsdas
		python ${D}/iraf/extern/stsdas/python/compileall.py ${D}/iraf/extern/stsdas/python
		python ${D}/iraf/extern/stsdas/python/compileall.py ${D}/iraf/extern/stsdas/python/*

		# clean-up archs and links
		einfo "     Removing extra arch-specific files and fixing links..."
		for pkg in stsdas tables
		do
			if [ -h "${D}/iraf/extern/${pkg}/bin" ]; then
				rm -f "${D}/iraf/extern/${pkg}/bin"
			fi
			ln -sf "${D}/iraf/extern/${pkg}/bin.linux" "${D}/iraf/extern/${pkg}/bin"
			for arch in alpha freebsd generic hp700 irix macintel macosx redhat rs6000 sparc ssun suse
			do
				dir="${D}/iraf/extern/${pkg}/bin.${arch}"
				if [ -e ${dir} ] || [ -h ${dir} ]; then
					rm -fr "${dir}"
				fi
			done
		done
	fi

	# change permissions on iraf directory tree
	einfo "Adjusting permissions in IRAF directory tree..."
	chown -R iraf:iraf ${D}/iraf
	find "${D}/iraf" -name "*.e" -exec chmod a+rx "{}" \;
	chown 0 "${D}/iraf/iraf/unix/bin.linux/alloc.e"
	chmod u+s "${D}/iraf/iraf/unix/bin.linux/alloc.e"
}

pkg_postinst() {
	einfo "Creating fifo pipes for image display (if needed) ..."
	for pipe in imt1i imt1o
	do
		if [ ! -e /dev/${pipe} ]; then
			mkfifo /dev/${pipe}
			chmod 777 /dev/${pipe}
		fi
	done
	if [ ! -e /dev/imt1 ]; then
		dosym /dev/imt1o /dev/imt1
	fi

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


