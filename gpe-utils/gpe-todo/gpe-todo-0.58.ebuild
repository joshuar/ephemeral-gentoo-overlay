# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GPE_TARBALL_SUFFIX="bz2"
GPE_MIRROR="http://gpe.linuxtogo.org/download/source"
inherit eutils gpe

DESCRIPTION="The GPE todo list manager"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# When gpe-conf goes into portage, we need to add a RDEPEND on it here.
RDEPEND="gpe-base/libgpewidget gpe-base/libgpepimc gpe-base/libtododb"
IUSE="${IUSE}"
