# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_P="geolocation_plugin-${PV}"

DESCRIPTION="Plugin provides GeoLocation functionality."
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.4"
DEPEND="${RDEPEND}
		>=media-libs/libchamplain-0.4.0[gtk]"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
