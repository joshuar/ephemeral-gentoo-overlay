# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils bash-completion

MY_PN=todo.txt-cli
MY_P=${MY_PN}-${PV}

DESCRIPTION="Powerful shell script that adds to, edits, sorts and searches a todo list text file from the command line."
HOMEPAGE="http://todotxt.com/library/todo.sh/"
SRC_URI="http://todotxt.com/library/todo.sh/${MY_P}.zip
		 bash-completion? ( http://todotxt.com/download/todo_completer.sh )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86"
IUSE="bash-completion"

S="${WORKDIR}"

src_unpack() {
	unpack "${MY_P}.zip"
	# replace todo.sh with todo in scripts
	# replace project.sh with todo-project in scripts
	sed -i -e 's:todo.sh:todo:g' \
		-e 's:project.sh:todo-project:g' \
		todo.sh \
		|| die "sed todo.sh failed."
	if use bash-completion; then
		cp ${DISTDIR}/todo_completer.sh ${S} \
			|| die "cp todo_completer.sh failed."
		sed -i -e 's:todo.sh:todo:g' todo_completer.sh \
			|| die "sed todo_completer.sh failed."
	fi
}

src_compile() {
	return 0
}

src_install() {
	newbin todo.sh todo
#	newbin project.sh todo-project
#   dodoc doc/{usage,changelog}.txt
	newdoc todo.cfg todo.cfg.example
	use bash-completion && dobashcompletion todo_completer.sh
}

pkg_postinst() {
	einfo "You will need to set up a new .todo file in your home area"
	einfo "before using ${PN}."
	einfo "See the todo.cfg.example file in the doc directory for usage."
	echo
	use bash-completion && bash-completion_pkg_postinst
}
