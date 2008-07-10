# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

DESCRIPTION="Wrapper over ruby-debug-base using add-hoc XML/pure-text protocol for communication with clients (usually debugger frontend like IDE or editors)."
HOMEPAGE="http://debug-commons.rubyforge.org/#ruby-debug-ide"
SRC_URI="mirror://rubyforge/debug-commons/${P}.gem"

LICENSE="MIT"
KEYWORDS="~x86"

RESTRICT="nomirror"

DEPEND=">=dev-ruby/ruby-debug-base-0.10.1"

