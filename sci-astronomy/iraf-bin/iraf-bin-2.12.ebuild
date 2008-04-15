# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils


DESCRIPTION="Image Reduction and Analysis Facility, a general purpose software system for the reduction and analysis of astronomical data."
HOMEPAGE="http://iraf.noao.edu/"
MY_PV="212"
SRC_URI="ftp://iraf.noao.edu/iraf/v${MY_PV}/PCIX/ib.lnux.x86.gz ftp://iraf.noao.edu/iraf/v${MY_PV}/PCIX/nb.lnux.x86.gz ftp://iraf.noao.edu/iraf/v${MY_PV}/PCIX/as.pcix.gen.gz"

LICENSE=""
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-shells/tcsh
sys-libs/libtermcap-compat
app-arch/sharutils"
DEPEND="${RDEPEND}"
PDEPEND="sys-libs/libtermcap-compat"


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
	# unpack the base file archive
	einfo "Installing base files..."
	iraf="/iraf/iraf"
	dodir ${iraf}
	cd "${D}/${iraf}"
	tar zxpf ${DISTDIR}/as.pcix.gen.gz
	# unpack the binary archives
	irafbin="/iraf/irafbin"
	dodir ${irafbin}
	dodir ${irafbin}/bin.linux
	cd "${D}/${irafbin}/bin.linux"
	tar zxpf ${DISTDIR}/ib.lnux.x86.gz
	dodir ${irafbin}/noao.bin.linux
	cd "${D}/${irafbin}/noao.bin.linux"
	tar zxpf ${DISTDIR}/nb.lnux.x86.gz

	# make the public image dir
	einfo "Creating public image dir..."
	diropts -m0777
	dodir "/iraf/imdirs"

	dodir /usr/bin
	dodir /usr/lib

	# patch then run run the install script
	cd "${D}/${iraf}/unix/hlib"
	epatch "${FILESDIR}/${PN}-installscript.patch"
	cd "${WORKDIR}"
	cat > installiraf.csh << EOF
setenv iraf ${D}/${iraf}
setenv imdir ${D}/iraf/imdirs
setenv lbin ${D}/usr/bin
setenv llib ${D}/usr/lib
cd \${D}/\${iraf}/unix/hlib
source irafuser.csh
./install -noedit
EOF
	einfo "Running install script..."
	csh installiraf.csh
	rm -f installiraf.csh

	return 1

#	# delete binaries/directories for other archs
#	einfo "Deleting unneeded binaries/directories..."
#	for arch in freebsd linuxppc macosx redhat sunos suse
#	do
#	for archdir in "${D}/${iraf}" "${D}/${iraf}/unix" "${D}/${iraf}/noao"
#	do
#		if [ -e "${archdir}/bin.${arch}" ]; then
#		rm -fr "${archdir}/bin.${arch}"
#		fi
#		if [ -e "${archdir}/as.${arch}" ]; then
#		rm -fr "${archdir}/as.${arch}"
#		fi
#	done
#	done

#	# install iraf.h as <iraf.h>
#	einfo "Installing iraf.h header file..."
#	insinto /usr/include
#	doins "${D}/${iraf}/unix/hlib/libc/iraf.h"

#	# Now change ownership of entire directory structure to iraf:root
#	cd "${D}"
#	chown -R iraf:iraf iraf

#	# change permissions on alloc.e task
#	chown root "${D}/${iraf}/unix/bin.linux/alloc.e"
#	chmod u+s "${D}/${iraf}/unix/bin.linux/alloc.e"

#	local linkfiles=cl.e mkiraf.csh mkmlist.csh generic.e mkpkg.e rmbin.e rmfiles.e rtar.e sgidispatch.e wtar.e rpp.e xpp.e xyacc.e xc.e
#	local bindirs=unix unix/bin.linux unix/hlib bin


}

