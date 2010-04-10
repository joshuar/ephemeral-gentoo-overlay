# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

/var/log/squeezeboxserver/scanner.log
/var/log/squeezeboxserver/server.log
/var/log/squeezeboxserver/perfmon.log
{
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
}
