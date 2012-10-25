# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit perl-app

MY_P="${PN}-v${PV}"
DESCRIPTION="Tool for converting and importing virtual machines to libvirt-managed KVM, or Red Hat Enterprise Virtualization."
HOMEPAGE="http://libguestfs.org/virt-v2v/"
SRC_URI="https://fedorahosted.org/releases/v/i/virt-v2v/${MY_P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-perl/Crypt-SSLeay
		dev-perl/DateTime
		perl-core/ExtUtils-Manifest
		dev-perl/IO-String
		dev-perl/libintl-perl
		>=virtual/perl-Module-Build-0.36
		dev-perl/Module-Find
		perl-core/Module-Pluggable
		dev-perl/Net-HTTP
		dev-perl/Term-ProgressBar
		dev-perl/Sys-Virt
		dev-perl/URI
		dev-perl/XML-DOM
		dev-perl/XML-DOM-XPath
		dev-perl/XML-Writer
		>=app-misc/hivex-1.2.2[perl]
		>=app-emulation/libvirt-0.8.1
		app-emulation/libguestfs[perl]"

RDEPEND="${DEPEND}
		 app-cdr/cdrkit
		 app-emulation/qemu"

S="${WORKDIR}/${MY_P}"
