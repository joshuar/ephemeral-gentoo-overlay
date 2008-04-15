# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils cmake-utils fortran

DESCRIPTION="Library of functions that are useful for making scientific plots."
HOMEPAGE="http://plplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/plplot/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="X agg cxx fortran gnome ifc itcl itk octave pango
pdf python qhull svg tetex tcl tk threads truetype java
wxwindows"

FORTRAN="gfortran g77 ifc"

DOCS="AUTHORS ChangeLog FAQ NEWS README SERVICE ToDo"

RESTRICT="nomirror"

DEPEND="gnome? ( gnome-base/libgnomeprintui
				 >dev-python/pygtk-2.12.0 )
		 java? ( dev-lang/swig )
		 jpeg? ( media-libs/gd )
		 pango? ( x11-libs/pango
				  media-libs/lasi )
		 pdf? ( x11-libs/cairo )
		 png? ( media-libs/gd )
		 qhull? ( media-libs/qhull )
		 svg? ( x11-libs/cairo )
		 tetex? ( app-text/jadetex )
		 truetype? ( >=media-libs/freetype-2
					   media-fonts/freefont-ttf )
		 tcl? ( dev-lang/tcl
				itcl? (dev-tcltk/itcl))
		 wxwindows? ( x11-libs/wxGTK
				agg? ( x11-libs/agg ))
		 X? ( x11-libs/libX11
				x11-libs/libXau
				x11-libs/libXdmcp
				tk? ( dev-lang/tk
					  itk? ( dev-tcltk/itk )))"
RDEPEND="dev-lang/perl
		 octave? ( sci-mathematics/octave )
		 python? ( dev-python/numeric )
		 ${DEPEND}"

pkg_setup() {
	if use fortran || use ifc; then
		# check for a fortran compiler if requested
		fortran_pkg_setup
	fi
}

src_unpack() {
	cd "${S}"
	unpack "${A}"
	if use truetype; then
		# fixes for freetype lib detection and compilation
		cd "${S}/cmake/modules"
		epatch "${FILESDIR}/${P}-findfreetype.patch"
		sed -i \
			-e 's:-I${FREETYPE_INCLUDE_DIR}:${FREETYPE_INCLUDE_DIR}:g' \
			"${S}/src/CMakeLists.txt" "${S}/cmake/modules/wxwidgets.cmake" \
			|| die "sed flags failed"
	fi
}

src_compile() {
	mycmakeargs="$(cmake-utils_use_enable cxx cxx)
				 $(cmake-utils_use_enable gnome gnome2)
				 $(cmake-utils_use_enable itcl itcl)
				 $(cmake-utils_use_enable itk itk)
				 $(cmake-utils_use_enable java java)
				 $(cmake-utils_use_enable octave octave)
				 $(cmake-utils_use_enable python python)
				 $(cmake-utils_use_enable tcl tcl)
				 $(cmake-utils_use_enable tk tk)
				 $(cmake-utils_use_enable wxwindows wxwidgets)
				 $(cmake-utils_has agg AGG)
				 $(cmake-utils_has qhull QHULL)
				 $(cmake-utils_has threads PTHREAD)
				 $(cmake-utils_has truetype FREETYPE)
				 $(cmake-utils_has pango PANGO)"

	# enable fortran if requested
	if use ifc || use fortran; then
		if [ $FORTRANC -eq 'g77' ]; then
			mycmakeargs="$(cmake-utils_use_enable fortran f77)
			${mycmakeargs}"
		else # FORTRANC eq gfortran or ifc
			mycmakeargs="$(cmake-utils_use_enable fortran f95)
			${mycmakeargs}"
		fi
	fi
	# compilation fails with multiple jobs
	cmake-utils_src_compile -j1
}
