# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools bash-completion

MY_PN="task"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A command-line to do list manager."
HOMEPAGE="http://taskwarrior.org/projects/show/taskwarrior/"
SRC_URI="http://www.taskwarrior.org/download/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bash-completion vim zsh-completion"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
		 zsh-completion? ( app-shells/zsh )"

S=${WORKDIR}/${MY_P}

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
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins "${S}/scripts/zsh/_task"
	fi
	dodoc ${DOCS}
}
