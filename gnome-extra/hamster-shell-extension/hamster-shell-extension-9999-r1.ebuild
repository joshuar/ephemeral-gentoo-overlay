# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_COMMIT='b7d3594cef'
inherit git-2 waf-utils

DESCRIPTION="Shell extension for hamster applet"
HOMEPAGE="https://github.com/tbaugis/hamster-shell-extension"
EGIT_REPO_URI="https://github.com/tbaugis/hamster-shell-extension.git"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="gnome-extra/hamster-applet"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_prepare() {
	epatch ${FILESDIR}/wscript-remove-glib-schema-compile.patch
}

src_configure() {
	# extracted from waf-utils eclass
	# remove --libdir option as not supported
	: ${WAF_BINARY:="${S}/waf"}

	tc-export AR CC CPP CXX RANLIB
	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" \"${WAF_BINARY}\" --prefix=${EPREFIX}/usr $@ configure"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" \
		"$@" \
		configure || die "configure failed"
}
