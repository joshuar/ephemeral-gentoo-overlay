# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="wxRemind"
MY_P="${MY_PN}-src-${PV}"

DESCRIPTION="Graphical front/back-end for the remind program."
HOMEPAGE="http://www.duke.edu/~dgraham/wxRemind/"
SRC_URI="http://www.duke.edu/~dgraham/wxRemind/${MY_P}.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-misc/remind
dev-python/python-dateutil
>=dev-python/wxpython-2.8.0.1
x11-themes/gnome-icon-theme"
DEPEND="app-arch/zip
${RDEPEND}"

RESTRICT="nomirror"

pkg_setup() {
	REMALERTFILES="version.py wxremindrc.py wxremalert.py"
	REMDATAFILES="version.py wxremindrc.py wxremdata.py"
	REMINDFILES="version.py version.py wxremindrc.py wxremind.py wxremdata.py wxremalert.py wxRemAbout.py wxRemDays.py wxRemEdit.py wxRemHelp.py wxRemHints.py"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	tar jxf "${FILESDIR}/${PN}-docs.tar.bz2" || die "unpack docs failed."
}

src_compile() {
	cd "${S}"
	echo "version = ${PV}" > version.py

	zip wxremalert.zip ${REMALERTFILES} || die "zip remalert failed"
	cat wxremalert.head wxremalert.zip > wxremalert || die "cat remalert failed"

	zip wxremdata.zip ${REMDATAFILES} || die "zip remdata failed"
	cat wxremdata.head wxremdata.zip > wxremdata || die "cat remdata failed"

	zip wxremind.zip ${REMINDFILES} || die "zip remind failed"
	cat wxremind.head wxremind.zip > wxremind || die "cat remind failed"
}

src_install() {
	cd "${S}"
	dobin wxremalert wxremdata wxremind
	dodoc docs/*
	make_desktop_entry wxremind wxRemind appointment.png 'Office;Calendar'
}
