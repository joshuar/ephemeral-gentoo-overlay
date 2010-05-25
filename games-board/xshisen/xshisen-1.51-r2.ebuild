# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools flag-o-matic games

DESCRIPTION="Puzzle game using 144 mahjong pieces, objective is to remove all the pieces on the board."
HOMEPAGE="http://www.techfirm.co.jp/~masaoki/xshisen.html"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="athena +motif"

DEPEND="x11-libs/libXaw
		x11-libs/libXmu
		x11-libs/libXpm
		x11-libs/openmotif"

pkg_setup() {
	LANGS="ja ja_JP ja_JP.JIS7 ja_JP.PCK ja_JP.SJIS ja_JP.eucJP ja_JP.ujis pl"
}


src_prepare() {
	epatch ${FILESDIR}/${P}-debian-10_oldfixes.patch
	epatch ${FILESDIR}/${P}-debian-11_manpage_fixes.patch
	# epatch ${FILESDIR}/${P}-debian-20_autotools_update.patch
	sed -i -e 's|CPPFLAGS="${CPPFLAGS} -I${x_includes}"|CPPFLAGS="${CPPFLAGS}"|' \
		-e 's:LIBS=.*:LIBS="-lXm -lUil -lMrm `pkg-config --libs xaw7 xpm` ${LIBS}":' \
		configure.in || die "sed configure.in failed."
	sed -i -e 's:$(CXX) $(LDFLAGS).*:$(CXX) -o $(exec_name)  $(OBJS) $(LDFLAGS) $(LIBS):' \
		Makefile.in || die "sed Makefile.in failed."
	eautoreconf
}

src_configure() {
	egamesconf \
		--enable-dupscore \
		--with-x \
		--with-motif \
		--with-motif-include=/usr/include/Xm \
		--with-motif-lib=/usr/$(get_libdir) \
		|| die "egamesconf failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_STATEDIR}"/${PN}
	doins ${PN}.scores || die "install scores file failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r pixmaps/*

	doman man/*

	# app defaults
	./xshisen -KCONV none < lang/XShisen.ad > XShisen.ad
	insinto /etc/X11/app-defaults
	newins XShisen.ad XShisen
	# language-specific app defaults
	for lang in ${LANGS}; do
		./xshisen -KCONV none < lang/XShisen.ad.${lang} > XShisen.ad.${lang}
		insinto /etc/X11/app-defaults/${lang}
		newins XShisen.ad.${lang} XShisen
	done

	dodoc ChangeLog README

	newicon ${S}/pixmaps/s2/m1.xpm ${PN}.xpm
	make_desktop_entry ${PN} XShisen ${PN}.xpm

	prepgamesdirs
}

