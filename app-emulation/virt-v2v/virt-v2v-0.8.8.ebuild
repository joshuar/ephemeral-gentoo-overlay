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
		dev-perl/IO-String
		virtual/perl-Module-Build
		perl-core/Module-Pluggable
		dev-perl/Term-ProgressBar
		dev-perl/Sys-Virt
		dev-perl/URI
		dev-perl/XML-DOM
		dev-perl/XML-DOM-XPath
		dev-perl/XML-Writer
		app-misc/hivex[perl]
		app-emulation/libvirt
		app-emulation/libguestfs[perl]"

RDEPEND="${DEPEND}
		 app-cdr/cdrkit
		 app-emulation/qemu-kvm"

S="${WORKDIR}/${MY_P}"
