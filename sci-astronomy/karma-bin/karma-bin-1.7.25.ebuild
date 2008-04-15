# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="karma"

DESCRIPTION="Toolkit for interprocess communications, authentication, encryption, graphics display, user interface and manipulating the Karma network data structure"
HOMEPAGE="http://www.atnf.csiro.au/computing/software/karma/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${MY_PN}/current/${MY_PN}.share-v${PV}.tar.gz ftp://ftp.atnf.csiro.au/pub/software/${MY_PN}/current/i386_Linux_libc6.3-v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror"

S=${WORKDIR}/karma

src_compile() {
    return
}

src_install() {
    cd ${S}
    instdir="/opt/karma"
    into ${instdir}
    rm -f bin/MultibeamView
    dobin bin/*
    dolib.so lib/*.so.${PV}
    dolib.so lib/*.so
    exeinto ${instdir}/csh_script
    doexe csh_script/*
    insinto ${instdir}/share
    doins share/*
    insinto ${instdir}/include
    doins include/*.h
    into ${instdir}/man/mann
    doman man/mann/*
    dodoc doc/README doc/README.lib doc/COPYING Release-1.7
    insinto /usr/share/doc/${PF}/cm_script
    doins cm_script/*
    doenvd ${FILESDIR}/99karma
}

pkg_postinst() {
    elog "If you wish to keep karma up to date,"
    elog "set up a cron job as follows that executes:"
    elog "/opt/karma/bin/install-karma /opt/karma"
}
