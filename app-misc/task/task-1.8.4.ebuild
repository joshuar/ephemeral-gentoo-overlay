# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools bash-completion

DESCRIPTION="A todo list GTD implementation, based on ideas from http://todotxt.org."
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://www.taskwarrior.org/download/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	sed -i -e "s:CXXFLAGS=.*:CXXFLAGS=${CXXFLAGS}:" \
		configure.ac \
		|| die "sed configure.ac failed."
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dobashcompletion "${S}/scripts/bash/task_completion.sh"
	dodoc ${DOCS}
}
