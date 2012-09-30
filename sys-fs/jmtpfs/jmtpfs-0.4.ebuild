# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="FUSE and libmtp based filesystem for accessing files on Android devices"
HOMEPAGE="http://research.jacquette.com/jmtpfs-exchanging-files-between-android-devices-and-linux/"
SRC_URI="http://research.jacquette.com/wp-content/uploads/2012/05/${P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome X"

DEPEND=">=media-libs/libmtp-1.1.0
		>=sys-fs/fuse-2.6"
RDEPEND="${DEPEND}"
