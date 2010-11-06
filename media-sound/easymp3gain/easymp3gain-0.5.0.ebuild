# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="GUI for MP3Gain, VorbisGain and AACGain"
HOMEPAGE="http://sourceforge.net/projects/easymp3gain/"
SRC_URI="mirror://sourceforge/${PN}/${PN}%20source/${P}/${P}.src.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="aac +gtk +mp3 qt4 vorbis linguas_it linguas_de"

DEPEND=">=dev-lang/fpc-2.4.0
		>=dev-lang/lazarus-0.9.28
		gtk? ( x11-libs/gtk+ )
		qt? ( x11-libs/qt-gui )"
RDEPEND="mp3? ( media-sound/mp3gain )
		 aac? ( media-sound/aacgain )
		 vorbis? ( media-sound/vorbisgain )
		 ${DEPEND}"

src_prepare() {
	if use qt4 && use gtk; then
		eerror "You must only enable either the gtk (default) or qt4"
		eerror "USE flag to build a single interface."
	fi
	sed -i -e "s|strKeyWord := 'index.'+ strLang + '.html';|strKeyWord := '/usr/share/doc/${P}/html/index.'+ strLang + '.html';|" \
		-e "s|strKeyWord := 'index.html';|strKeyWord := '/usr/share/doc/${P}/html/index.html';|" \
		unitmain.pas \
		|| die "sed unitmain.pas failed"
	sed -i -e "s|PODirectory := strBinDir + 'lang/';|PODirectory := '/usr/share/${P}/lang/';|" \
		unittranslate.pas \
		|| die "sed unittranslate.pas failed"
}

src_compile() {
	if use gtk; then
		mkdir bin
		lazbuild -B --ws=gtk2 easymp3gain.lpr \
			|| die
	fi
	if use qt4; then
		mkdir bin
		lazbuild -B --ws=qt easymp3gain.lpr \
			|| die
	fi
}

src_install() {
	dobin bin/easymp3gain || die
	domenu applications/easymp3gain.desktop
	dodoc AUTHORS CHANGELOG.txt README.txt RELEASE.txt
	dohtml help/{index,install}.html
	use linguas_de && doin help/{index,install}.de.html
	doicon easymp3gain.ico icons/*
	newicon icons/easymp3gain-48.png ${PN}.png
	strip-linguas de it
	insinto /usr/share/${P}/lang
	doins lang/${PN}.po
	use linguas_de && doins lang/${PN}.de.po
	use linguas_it && doins lang/${PN}.it.po
}
