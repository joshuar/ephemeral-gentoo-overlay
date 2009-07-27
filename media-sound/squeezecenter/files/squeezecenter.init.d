#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezecenter/files/squeezecenter.init.d,v 1.3 2008/12/20 01:24:43 lavajoe Exp $

# These fit the SqueezeCenter ebuild and so shouldn't need to be changed;
# user-servicable parts go in /etc/conf.d/squeezecenter.
pidfile=/var/run/squeezecenter/squeezecenter.pid
logdir=/var/log/squeezecenter
varlibdir=/var/lib/squeezecenter
prefsdir=${varlibdir}/prefs
cachedir=${varlibdir}/cache
prefsfile=${prefsdir}/squeezecenter.prefs
scuser=squeezecenter
scname=squeezecenter-server

depend() {
	need net mysql
}

start() {
	ebegin "Starting SqueezeCenter"

	export SSD_NICELEVEL=${SC_NICENESS}
	cd /
	start-stop-daemon \
		--start --exec /usr/bin/perl /usr/sbin/${scname} \
		--pidfile ${pidfile} \
		--startas /usr/sbin/${scname} \
		--chuid ${scuser} \
		-- \
		--quiet --daemon \
		--pidfile=${pidfile} \
		--cachedir=${cachedir} \
		--prefsfile=${prefsfile} \
		--prefsdir=${prefsdir} \
		--logdir=${logdir} \
		--audiodir=${SC_MUSIC_DIR} \
		--playlistdir=${SC_PLAYLISTS_DIR} \
		${SC_OPTS}


	eend $? "Failed to start SqueezeCenter"
}

stop() {
	ebegin "Stopping SqueezeCenter"
	start-stop-daemon -o --stop --pidfile ${pidfile}
	eend $? "Failed to stop SqueezeCenter"
}
