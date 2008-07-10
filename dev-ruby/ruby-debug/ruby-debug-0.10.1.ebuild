# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="CLI interface to ruby-debug"
HOMEPAGE="http://rubyforge.org/projects/ruby-debug/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="ruby-debug"
KEYWORDS="~x86"

RESTRICT="nomirror"

DEPEND="=dev-ruby/ruby-debug-base-0.10.1
		=dev-ruby/columnize-0.1
		>=dev-lang/ruby-1.8.4"
RDEPEND="${DEPEND}"
