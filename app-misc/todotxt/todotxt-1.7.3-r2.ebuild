# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils bash-completion

DESCRIPTION="Powerful shell script that adds to, edits, sorts and searches a todo list text file from the command line."
HOMEPAGE="http://todotxt.com/library/todo.sh/"
SRC_URI="http://todotxt.googlecode.com/files/todotxt-bundle-1.0.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nomirror"

src_unpack() {
	unpack "${A}"
	cd "${WORKDIR}/bin"
	# replace todo.sh with todo in scripts
	sed -i 's:todo.sh:todo:' {todo,project}.sh
	# replace project.sh with todo-project in scripts
	sed -i 's:project.sh:todo-project:' {todo,project}.sh
}

src_compile() {
	return 0
}

src_install() {
	newbin bin/todo.sh todo
	newbin bin/project.sh todo-project
	dodoc doc/{usage,changelog}.txt
	dobashcompletion .bash_completion.d/todo_completer.sh
}

pkg_postinst() {
	einfo "You will need to set up a new .todo file in your home area"
	einfo "before using ${PN}."
	einfo "See the usage.txt file in the doc directory for usage."
	echo
	bash-completion_pkg_postinst
}
