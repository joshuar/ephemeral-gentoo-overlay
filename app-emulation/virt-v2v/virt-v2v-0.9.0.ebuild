# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit perl-app

MY_P="${PN}-v${PV}"
DESCRIPTION="Convert a virtual machine to run on KVM"
HOMEPAGE="http://libguestfs.org/virt-v2v/"
SRC_URI="https://fedorahosted.org/releases/v/i/virt-v2v/${MY_P}.tar.gz"
LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-devel/gettext
virtual/perl-Module-Build
virtual/perl-ExtUtils-Manifest
dev-perl/Archive-Extract
dev-perl/Module-Find
dev-perl/Crypt-SSLeay
dev-perl/DateTime
dev-perl/Digest-SHA1
dev-perl/IO-String
dev-perl/libintl-perl
virtual/perl-Module-Pluggable
dev-perl/Net-HTTP
virtual/perl-Sys-Syslog
>=dev-perl/Sys-Virt-0.2.4
dev-perl/Term-ProgressBar
dev-perl/URI
dev-perl/XML-DOM
dev-perl/XML-DOM-XPath
dev-perl/XML-Writer
app-cdr/cdrkit
app-emulation/qemu
>=app-misc/hivex-1.2.2[perl]
>=app-emulation/libguestfs-1.14.0[perl]
>=app-emulation/libvirt-0.8.1"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install () {
	perl-module_src_install
	insinto /etc
	doins v2v/virt-v2v.conf
	insinto /var/lib/${PN}
	doins v2v/virt-v2v.db
	insinto /var/lib/${PN}/software/windows
	doins windows/rhsrvany.exe windows/firstboot.bat
}
