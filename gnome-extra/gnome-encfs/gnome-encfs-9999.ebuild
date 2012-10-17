# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit mercurial

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://foo.example.org/"
EHG_REPO_URI="http://bitbucket.org/obensonne/gnome-encfs"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-python/pygtk
		 dev-python/gnome-keyring-python
		 sys-fs/encfs"

src_install() {
	dobin gnome-encfs
	newdoc README.md README
}
