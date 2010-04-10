#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

pidfile=/var/run/squeezeboxserver/squeezeboxserver.pid
logdir=/var/log/squeezeboxserver
varlibdir=/var/lib/squeezeboxserver
prefsdir=${varlibdir}/prefs
cachedir=${varlibdir}/cache
prefsfile=${prefsdir}/squeezeboxserver.prefs
scuser=squeezeboxserver
scgroup=squeezeboxserver
scname=squeezeboxserver-server

depend() {
    need net mysql
}

start() {
    ebegin "Starting Squeezebox Server"
    if [[ ${SC_NICENESS} ]]; then 
	export SSD_NICELEVEL=${SC_NICENESS}
    fi
    if [[ ${SC_MUSIC_DIR} ]]; then
	SC_OPTS="--audiodir=${SC_MUSIC_DIR} ${SC_OPTS}"
    fi
    if [[ ${SC_PLAYLISTS_DIR} ]]; then
	SC_OPTS="--playlistdir=${SC_PLAYLISTS_DIR} ${SC_OPTS}"
    fi
    
    cd /var/empty
    start-stop-daemon \
	--start --exec /usr/bin/perl /usr/sbin/${scname} \
	--pidfile ${pidfile} \
	--startas /usr/sbin/${scname} \
	--chuid ${scuser} \
	--group ${scgroup} \
	-- \
	--quiet --daemon \
	--pidfile=${pidfile} \
	--cachedir=${cachedir} \
		--prefsfile=${prefsfile} \
	--prefsdir=${prefsdir} \
	--logdir=${logdir} \
	--charset utf8 \
	${SC_OPTS}
    eend $? "Failed to start Squeezebox Server"
}

stop() {
    ebegin "Stopping Squeezebox Server"
    start-stop-daemon --stop --pidfile ${pidfile}
    eend $? "Failed to stop Squeezebox Server"
}
