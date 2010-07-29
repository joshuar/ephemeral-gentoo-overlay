# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils distutils games

MY_PN="PySolFC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PySolFC is a collection of more than 1000 solitaire card games."
HOMEPAGE="http://pysolfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pysolfc/${MY_P}.tar.bz2
	extra-cardsets? ( mirror://sourceforge/pysolfc/${MY_PN}-Cardsets-${PV}.tar.bz2 )
	music? ( ftp://ibiblio.org/pub/linux/games/solitaires/pysol-music-4.40.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra-cardsets imaging music tile"

RDEPEND="tile? ( dev-tcltk/tktable )
	imaging? ( dev-python/imaging[tk] )
	music? ( dev-python/pygame )
	>=dev-lang/tk-8.4"

PYTHON_USE_WITH="xml"
PYTHON_MODNAME="pysollib"
DDOCS="PKG-INFO docs/README docs/README.SOURCE"
S="${WORKDIR}/${MY_P}"
S_CARDSETS="${WORKDIR}/${MY_PN}-Cardsets-${PV}"
S_MUSIC="${WORKDIR}/pysol-music-4.40"

pkg_setup() {
	python_pkg_setup
	games_pkg_setup
}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	use extra-cardsets && unpack ${MY_PN}-Cardsets-${PV}.tar.bz2
	use music && unpack pysol-music-4.40.tar.gz
	cd "${S}"
	sed -i -e '/pysolfc.glade/d' \
		-e '/pysol.xpm/d' \
		-e "s|data_dir =.*|data_dir = \'games/$(get_libdir)/pysolfc\'|" \
		-e 's|share/icons|share/pixmaps|' \
		setup.py || die "sed setup.py failed."

	sed -i -e 's|pysol.py|pysolfc|' \
		-e 's|/usr/share/icons/pysol01.png|pysol01.png|' \
		data/pysol.desktop \
		|| die "sed pysol.desktop failed."
}

# there is no compilation needed, so define an empty src_compile
# so the games and distutils eclasses do not do stuff
src_compile() {
	return 0
}

src_install() {
	distutils_src_install

	rm -f ${D}/usr/bin/pysol.py
	exeinto "$(games_get_libdir)"/${PN}
	doexe pysol.py
	games_make_wrapper ${PN} "python ./pysol.py" "$(games_get_libdir)"/${PN}

	doman docs/pysol.6

	if use extra-cardsets; then
		insinto "$(games_get_libdir)"/${PN}
		cd ${S_CARDSETS}
		doins -r * \
			|| die "install extra cardsets failed."
	fi

	if use music; then
		insinto "$(games_get_libdir)"/${PN}/music
		cd ${S_MUSIC}
		doins data/music/* \
			|| die "install music failed."
	fi
}

pkg_postinst() {
	python_mod_optimize "$(games_get_libdir)"/${PN}
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)"/${PN}
}
