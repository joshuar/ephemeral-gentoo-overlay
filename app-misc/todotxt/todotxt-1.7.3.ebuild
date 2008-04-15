# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="todo"

DESCRIPTION="Powerful shell script that adds to, edits, sorts and searches a todo list text file from the command line."
HOMEPAGE="http://todotxt.com/library/todo.sh/"
SRC_URI="http://todotxt.com/download/${MY_PN}.sh.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

src_compile() {
	return 0
}

src_install() {
	cd "${S}"
	newbin todo.sh todo
	insinto /usr/share/doc/"${P}"
	newins .todo todo.sample
}

pkg_postinst() {
	einfo "You will need to set up a new .todo file in your home area"
	einfo "before using ${PN}.  You can copy:"
	einfo "    /usr/share/doc/${P}/todo.sample"
	einfo "and change the TODO_DIR path to wherever you want todo to"
	einfo "store its files."
}
