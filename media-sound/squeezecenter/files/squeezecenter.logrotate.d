# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezecenter/files/squeezecenter.logrotate.d,v 1.1 2008/08/03 04:35:29 lavajoe Exp $

/var/log/squeezecenter/scanner.log /var/log/squeezecenter/server.log /var/log/squeezecenter/perfmon.log {
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
}
