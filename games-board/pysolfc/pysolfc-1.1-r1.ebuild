# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils distutils games

MY_PN="PySolFC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PySolFC is a collection of more than 1000 solitaire card games. It is a fork of PySol Solitaire."
HOMEPAGE="http://pysolfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pysolfc/${MY_P}.tar.bz2
	extra-cardsets? ( mirror://sourceforge/pysolfc/${MY_PN}-Cardsets-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86"
IUSE="extra-cardsets imaging music tile"

RDEPEND="tile? ( dev-tcltk/tktable )
	imaging? ( dev-python/imaging[tk] )
	music? ( || ( >=games-board/pysol-sound-server-3.0
				  dev-python/pygame ) )
	>=dev-lang/tk-8.4"

PYTHON_MODNAME="pysollib"
DDOCS="PKG-INFO docs/README docs/README.SOURCE"
S="${WORKDIR}/${MY_P}"
S_CARDSETS="${WORKDIR}/${MY_PN}-Cardsets-${PV}"

pkg_setup() {
	distutils_python_tkinter
	games_pkg_setup
}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	use extra-cardsets && unpack ${MY_PN}-Cardsets-${PV}.tar.bz2
	cd "${S}"
	sed -i -e '/pysolfc.glade/d' \
		-e '/pysol.xpm/d' \
		-e "s:data_dir =.*:data_dir = \'games/$(get_libdir)/pysolfc\':" \
		setup.py || die "sed setup.py failed."
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

	insinto /usr/share/pixmaps
	newicon data/pysol.xpm ${PN}.xpm
	newicon data/pysol.xbm ${PN}.xbm

	doman docs/pysol.6

	make_desktop_entry ${PN} PySolFC ${PN}.xpm

	if use extra-cardsets; then
		insinto "$(games_get_libdir)"/${PN}
		cd "${S_CARDSETS}"
		doins -r * \
			|| die "install extra cardsets failed."
	fi
}

pkg_postinst() {
	python_mod_optimize "$(games_get_libdir)"/${PN}
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)"/${PN}
}
