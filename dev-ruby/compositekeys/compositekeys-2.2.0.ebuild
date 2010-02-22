# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

MY_PN="composite_primary_keys"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Extension to ActiveRecords to support composite primary keys."
HOMEPAGE="http://compositekeys.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-ruby/rails-2.2"

RESTRICT="primaryuri"


