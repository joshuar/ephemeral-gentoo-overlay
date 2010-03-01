#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

# These fit the SqueezeCenter ebuild and so shouldn't need to be changed;
# user-servicable parts go in /etc/conf.d/squeezeboxserver.
pidfile=/var/run/squeezeboxserver/squeezeboxserver.pid
logdir=/var/log/squeezeboxserver
varlibdir=/var/lib/squeezeboxserver
prefsdir=${varlibdir}/prefs
cachedir=${varlibdir}/cache
prefsfile=${prefsdir}/squeezeboxserver.prefs
scuser=squeezeboxserver
scname=squeezeboxserver-server

depend() {
	need net mysql
}

start() {
	ebegin "Starting SqueezeCenter"
	if [[ ${SC_NICENESS} ]]; then 
	    export SSD_NICELEVEL=${SC_NICENESS}
	fi
	if [[ ${SC_MUSIC_DIR} ]]; then
	    SC_OPTS="--audiodir=${SC_MUSIC_DIR} ${SC_OPTS}"
	fi
	if [[ ${SC_PLAYLISTS_DIR} ]]; then
	    SC_OPTS="--playlistdir=${SC_PLAYLISTS_DIR} ${SC_OPTS}"
	fi

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
		${SC_OPTS} \
	    || eerror "Failed to start SqueezeCenter"
	
}

stop() {
	ebegin "Stopping SqueezeCenter"
	start-stop-daemon -o --stop --pidfile ${pidfile} \
	    || eerror "Failed to stop SqueezeCenter"
}

restart() {
    stop
    sleep 5
    start
}
