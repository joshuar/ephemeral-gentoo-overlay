# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit flag-o-matic

MY_PL=${PV#*_p}
MY_PV=${PV%_*}
MY_P=${PN}-v${MY_PV}-pl${MY_PL}

DESCRIPTION="A Free DJ Tool"
HOMEPAGE="http://bpmdj.yellowcouch.org/index.html"
SRC_URI="ftp://bpmdj.yellowcouch.org/bpmdj/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sci-libs/fftw:3.0
		media-sound/jack-audio-connection-kit
		media-sound/lame
		media-sound/mpg123
		x11-libs/qt-gui
		x11-libs/qt-core"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_unpack() {
	cd ${WORKDIR}
	mkdir ${MY_P} && cd ${MY_P}
	unpack ${A}
}

src_prepare() {
	cp ${FILESDIR}/defines ${S}/defines
	echo "QT_INCLUDE_PATH=$(pkg-config --cflags QtCore QtGui)" >> ${S}/defines
	echo "QT_LIBRARY_PATH=$(pkg-config --libs-only-L QtCore QtGui)" >> ${S}/defines
	echo "QT_LIBS=$(pkg-config --libs-only-l QtCore QtGui)" >> ${S}/defines
	echo "LDFLAGS+=$(pkg-config --libs alsa fftw3 jack)" >> ${S}/defines
	sed -i -e "s|/tmp|${T}|g" sources || die
}

src_configure() {
	:
}

src_compile() {
	CXX=$(tc-getCXX) \
		emake -j1 || die
}

src_install() {
	dobin bpmcount bpmplay bpmdj bpmmerge
	dodoc authors.txt  changelog.txt readme.txt support.txt
}
