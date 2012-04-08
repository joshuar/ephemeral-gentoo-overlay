# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

NEED_EMACS="24"

inherit elisp git-2

DESCRIPTION="Solarized color theme for Emacs"
HOMEPAGE="http://github.com/sellout/emacs-color-theme-solarized"
EGIT_REPO_URI="https://github.com/sellout/emacs-color-theme-solarized.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

pkg_postinst() {
	elisp-site-regen
	elog "To enable solarized by default, initialise it in your ~/.emacs:"
	elog "   (solarized-light) or"
	elog "   (solarized-dark)"
}
