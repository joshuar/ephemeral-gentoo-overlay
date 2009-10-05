# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeboxserver/files/squeezeboxserver.logrotate.d,v 1.1 2008/08/03 04:35:29 lavajoe Exp $

/var/log/squeezeboxserver/scanner.log /var/log/squeezeboxserver/server.log /var/log/squeezeboxserver/perfmon.log {
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
}
