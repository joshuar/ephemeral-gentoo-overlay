# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MAJOR_VER="${PV:0:3}"
MINOR_VER="${PV:4:1}"
REVISION=${PV#${MAJOR_VER}.${MINOR_VER}_rc}

MY_P="${PN}-${MAJOR_VER}.${MINOR_VER}-${REVISION}-noCPAN"

DESCRIPTION="Logitech SqueezeboxServer music server"
HOMEPAGE="http://www.logitechsqueezebox.com/support/download-squeezebox-server.html"
SRC_URI="http://downloads.slimdevices.com/SqueezeboxServer_v7.4.0/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+lame wavpack logrotate musepack alac ogg bonjour flac avahi aac"

## TODO: Sort through this dependancy list and work and what pulls in what
DEPEND="
virtual/logger
virtual/mysql
avahi? ( net-dns/avahi )
media-libs/gd[jpeg,png]
dev-perl/Algorithm-C3
dev-perl/AnyEvent
dev-perl/Archive-Zip
dev-perl/Audio-FLAC-Header
dev-perl/Audio-Scan[flac=]
dev-perl/Audio-Wav
dev-perl/Audio-WMA
dev-perl/Cache-Cache
dev-perl/Carp-Assert
dev-perl/Carp-Clan
dev-perl/Class-Accessor
dev-perl/Class-Accessor-Chained
dev-perl/Class-Accessor-Grouped
dev-perl/Class-C3
dev-perl/Class-C3-Componentised
dev-perl/Class-Data-Accessor
dev-perl/Class-Data-Inheritable
dev-perl/Class-ErrorHandler
dev-perl/Class-Inspector
dev-perl/class-loader
dev-perl/Class-MethodMaker
dev-perl/Class-Singleton
dev-perl/Class-Virtual
dev-perl/Class-XSAccessor-Array
dev-perl/common-sense
dev-perl/Crypt-SSLeay
dev-perl/data-buffer
dev-perl/Data-Dump
dev-perl/Data-Page
dev-perl/Data-URIEncode
dev-perl/DateManip
dev-perl/DateTime-Locale
dev-perl/DBD-mysql
dev-perl/DBD-SQLite
dev-perl/DBI
dev-perl/DBIx-Class
!dev-perl/DBIx-Migration
dev-perl/Digest-HMAC
dev-perl/digest-md2
dev-perl/Digest-SHA1
dev-perl/Encode-Detect
dev-perl/Exporter-Lite
dev-perl/File-BOM
dev-perl/File-Find-Rule
dev-perl/File-HomeDir
dev-perl/File-Next
dev-perl/File-ReadBackwards
dev-perl/File-Slurp
dev-perl/File-Which
dev-perl/GD
dev-perl/GDGraph
dev-perl/GD-Graph3d
dev-perl/GDTextUtil
dev-perl/HTML-Parser
dev-perl/HTML-Tagset
dev-perl/HTML-Tree
dev-perl/IO-Socket-SSL
dev-perl/IO-String
dev-perl/IO-Tty
dev-perl/JSON
dev-perl/JSON-Any
dev-perl/JSON-XS
dev-perl/JSON-XS-VersionOneAndTwo
dev-perl/libwww-perl
dev-perl/libxml-perl
dev-perl/Locale-gettext
dev-perl/Log-Agent
dev-perl/Log-Log4perl
dev-perl/math-pari
dev-perl/Math-VecStat
dev-perl/Module-Find
dev-perl/Module-Signature
dev-perl/MP3-Tag
dev-perl/MPEG-Audio-Frame
dev-perl/MRO-Compat
dev-perl/Net-Daemon
dev-perl/Net-DNS
dev-perl/Net-IP
dev-perl/Net-SMTP-SSL
dev-perl/Net-SSLeay
dev-perl/Net-UPnP
dev-perl/PAR
dev-perl/PAR-Dist
dev-perl/Path-Class
dev-perl/Proc-Background
dev-perl/Scope-Guard
dev-perl/SQL-Abstract
dev-perl/SQL-Abstract-Limit
dev-perl/Sub-Name
dev-perl/Template-DBI
dev-perl/Template-GD
dev-perl/Template-Toolkit
dev-perl/Template-XML
dev-perl/Test-Deep
dev-perl/text-autoformat
dev-perl/Text-CharWidth
dev-perl/Text-Glob
dev-perl/text-reform
dev-perl/Text-Unidecode
dev-perl/Text-WrapI18N
dev-perl/Tie-Cache-LRU
dev-perl/Tie-Cache-LRU-Expires
dev-perl/tie-encryptedhash
dev-perl/Tie-IxHash
dev-perl/Tie-LLHash
dev-perl/Tie-RegexpHash
dev-perl/TimeDate
dev-perl/URI
dev-perl/URI-Find
dev-perl/XML-DOM
dev-perl/XML-LibXML
dev-perl/XML-LibXML-Common
dev-perl/XML-NamespaceSupport
dev-perl/XML-Parser
dev-perl/XML-RegExp
dev-perl/XML-RSS
dev-perl/XML-SAX
dev-perl/XML-Simple
dev-perl/XML-XPath
dev-perl/XML-XQL
dev-perl/yaml
dev-perl/YAML-Syck
"

DOCS="Changelog*.html License.txt"
PREFS=/var/lib/${PN}/prefs/${PN}.prefs
LIVE_PREFS=/var/lib/${PN}/prefs/server.prefs
SBS_USER="squeezeboxserver"
SBS_GROUP="squeezeboxserver"
DBUSER=${PN}

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# Create the user and group if not already present
	enewgroup ${SBS_GROUP}
	enewuser ${SBS_USER} -1 -1 "/dev/null" ${SBS_USER}
}


src_install() {
	# The main Perl executables
	newsbin slimserver.pl ${PN}-server
	newsbin scanner.pl ${PN}-scanner
	newsbin cleanup.pl ${PN}-cleanup

	# Get the Perl package name and version
	eval `perl '-V:package'`
	eval `perl '-V:version'`
	# The server Perl modules
	insinto "/usr/lib/${package}/vendor_perl/${version}"
	doins -r Slim
	# The custom OS module for Gentoo - provides OS-specific path details
	insinto "/usr/lib/${package}/vendor_perl/${version}/Slim/Utils/OS"
	newins "${FILESDIR}/gentoo-filepaths.pm" Custom.pm

	# Various directories of architecture-independent static files
	insinto "/usr/share/${PN}"
	doins -r Firmware Graphics HTML IR SQL strings.txt revision.txt

	# Squeezebox Server devs have their own customised version of DBIx-Migration
	# that does a few things different than the years old latest version on CPAN.
	# Assume the Squeezebox Server devs know what they are doing.
	insinto "/usr/lib/${PN}"
	doins -r lib/DBIx

	# Documentation
	dodoc ${DOCS} "${FILESDIR}/Gentoo-plugins-README.txt"

	# Configuration and Preferences files
	insinto /etc/${PN}
	doins convert.conf types.conf modules.conf
	insinto /var/lib/${PN}/prefs
	newins "${FILESDIR}/${PN}.prefs" ${PN}.prefs \
		or die "Failed to install preferences file."
	fowners ${SBS_USER}:${SBS_GROUP} /var/lib/${PN}/prefs
	fperms 770 /var/lib/${PN}/prefs

	# Install init scripts
	newconfd "${FILESDIR}/${PN}.conf.d" ${PN} \
		or die "Failed to install conf.d file."
	newinitd "${FILESDIR}/${PN}.init.d" ${PN} \
		or die "Failed to install init.d script."

	# Install the SQL configuration scripts
	insinto /usr/share/${PN}/SQL/mysql
	doins "${FILESDIR}/dbdrop-gentoo.sql" "${FILESDIR}/dbcreate-gentoo.sql"

	# Initialize run directory (where the PID file lives)
	dodir /var/run/${PN}
	fowners ${SBS_USER}:${SBS_GROUP} /var/run/${PN}
	fperms 770 /var/run/${PN}

	# Initialize server cache directory
	dodir /var/lib/${PN}/cache
	fowners ${SBS_USER}:${SBS_GROUP} /var/lib/${PN}/cache
	fperms 770 /var/lib/${PN}/cache

	# Initialize the log directory
	dodir /var/log/${PN}
	fowners ${SBS_USER}:${SBS_GROUP} /var/log/${PN}
	fperms 770 /var/log/${PN}
	touch "${D}/var/log/${PN}/server.log"
	touch "${D}/var/log/${PN}/scanner.log"
	touch "${D}/var/log/${PN}/perfmon.log"
	fowners ${SBS_USER}:${SBS_GROUP} /var/log/${PN}/server.log
	fowners ${SBS_USER}:${SBS_GROUP} /var/log/${PN}/scanner.log
	fowners ${SBS_USER}:${SBS_GROUP} /var/log/${PN}/perfmon.log

	# Initialise the user-installed plugins directory
	dodir "${NEWPLUGINSDIR}"

	# Install logrotate support
	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/${PN}.logrotate.d" ${PN}
	fi

	# Install Avahi support (if USE flag is set)
	if use avahi; then
		insinto /etc/avahi/services
		newins "${FILESDIR}/avahi-${PN}.service" ${PN}.service
	fi
}


sc_starting_instr() {
	elog "Squeezebox Server can be started with the following command:"
	elog "\t/etc/init.d/${PN} start"
	elog ""
	elog "Squeezebox Server can be automatically started on each boot with the"
	elog "following command:"
	elog "\trc-update add ${PN} default"
	elog ""
	elog "You might want to examine and modify the following configuration"
	elog "file before starting Squeezebox Server:"
	elog "\t/etc/conf.d/${PN}"
	elog ""

	# Discover the port number from the preferences, but if it isn't there
	# then report the standard one.
	httpport=$(gawk '$1 == "httpport:" { print $2 }' "${ROOT}${LIVE_PREFS}" 2>/dev/null)
	elog "You may access and configure Squeezebox Server by browsing to:"
	elog "\thttp://localhost:${httpport:-9000}/"
}

pkg_postinst() {
	# FLAC and LAME are quite useful (but not essential) -
	# if they're not enabled then make sure the user understands that.
	if ! use flac; then
		ewarn "'flac' USE flag is not set.  Although not essential, FLAC is required"
		ewarn "for playing lossless WAV and FLAC (for Squeezebox 1), and for"
		ewarn "playing other less common file types (if you have a Squeezebox 2, 3,"
		ewarn "Receiver or Transporter)."
		ewarn "For maximum flexibility you are recommended to set the 'flac' USE flag".
		ewarn ""
	fi
	if ! use lame; then
		ewarn "'lame' USE flag is not set.  Although not essential, LAME is"
		ewarn "required if you want to limit the bandwidth your Squeezebox or"
		ewarn "Transporter uses when streaming audio."
		ewarn "For maximum flexibility you are recommended to set the 'lame' USE flag".
		ewarn ""
	fi

	# Point user to database configuration step
	elog "If this is a new installation of Squeezebox Server then the database"
	elog "must be configured prior to use.  This can be done by running the"
	elog "following command:"
	elog "\temerge --config =${CATEGORY}/${PF}"

	# Remind user to configure Avahi if necessary
	if use avahi; then
		elog ""
		elog "Avahi support installed.  Remember to edit the folowing file if"
		elog "you run the Squeezebox Server's web interface on a port other than 9000:"
		elog "\t/etc/avahi/services/${PN}.service"
	fi

	elog ""
	sc_starting_instr

	elog ""
	elog "Apologies, there is no migration support from Squeezecenter versions 7.3.x yet."
	elog "Patches to this ebuild to make it happen are welcome..."
}

sc_remove_db_prefs() {
	MY_PREFS=$1

	einfo "Configuring Squeezebox Server database preferences (${MY_PREFS}) ..."
	TMPPREFS="${T}"/${PN}-prefs-$$
	touch "${ROOT}${MY_PREFS}"
	sed -e '/^dbusername:/d' -e '/^dbpassword:/d' -e '/^dbsource:/d' < "${ROOT}${MY_PREFS}" > "${TMPPREFS}"
	mv "${TMPPREFS}" "${ROOT}${MY_PREFS}"
	chown ${SBS_USER}:${SBS_GROUP} "${ROOT}${MY_PREFS}"
	chmod 660 "${ROOT}${MY_PREFS}"
}

sc_update_prefs() {
	MY_PREFS=$1
	MY_DBUSER=$2
	MY_DBUSER_PASSWD=$3

	echo "dbusername: ${MY_DBUSER}" >> "${ROOT}${MY_PREFS}"
	echo "dbpassword: ${MY_DBUSER_PASSWD}" >> "${ROOT}${MY_PREFS}"
	echo "dbsource: dbi:mysql:${MY_DBUSER}" >> "${ROOT}${MY_PREFS}"
}

pkg_config() {
	einfo "Press ENTER to create the Squeezebox Server database and set proper"
	einfo "permissions on it.  You will be prompted for the MySQL 'root' user's"
	einfo "password during this process (note that the MySQL 'root' user is"
	einfo "independent of the Linux 'root' user and so may have a different"
	einfo "password)."
	einfo ""
	einfo "If you already have a Squeezebox Server database set up then this"
	einfo "process will clear the existing database (your music files will not,"
	einfo "however, be affected)."
	einfo ""
	einfo "Alternatively, press Control-C to abort now..."
	read

	# Get the MySQL root password from the user (not echoed to the terminal)
	einfo "The MySQL 'root' user password is required to create the"
	einfo "Squeezebox Server user and database."
	DONE=0
	while [ $DONE -eq 0 ]; do
		trap "stty echo; echo" EXIT
		stty -echo
		read -p "MySQL root password: " ROOT_PASSWD; echo
		stty echo
		trap ":" EXIT
		echo quit | mysql --user=root --password="${ROOT_PASSWD}" >/dev/null 2>&1 && DONE=1
		if [ $DONE -eq 0 ]; then
			eerror "Incorrect MySQL root password, or MySQL is not running"
		fi
	done

	# Get the new password for the Squeezebox Server MySQL database user, and
	# have it re-entered to confirm it.  We should trivially check it's not
	# the same as the MySQL root password.
	einfo "A new MySQL user will be added to own the Squeezebox Server database."
	einfo "Please enter the password for this new user (${DBUSER})."
	DONE=0
	while [ $DONE -eq 0 ]; do
		trap "stty echo; echo" EXIT
		stty -echo
		read -p "MySQL ${DBUSER} password: " DBUSER_PASSWD; echo
		stty echo
		trap ":" EXIT
		if [ -z "$DBUSER_PASSWD" ]; then
			eerror "The password should not be blank; try again."
		elif [ "$DBUSER_PASSWD" == "$ROOT_PASSWD" ]; then
			eerror "The ${DBUSER} password should be different to the root password"
		else
			DONE=1
		fi
	done

	# Drop the existing database and user - note we don't care about errors
	# from this as it probably just indicates that the database wasn't
	# yet present.
	einfo "Dropping old Squeezebox Server database and user ..."
	sed -e "s/__DATABASE__/${DBUSER}/" -e "s/__DBUSER__/${DBUSER}/" < "/usr/share/${PN}/SQL/mysql/dbdrop-gentoo.sql" | mysql --user=root --password="${ROOT_PASSWD}" >/dev/null 2>&1

	# Drop and create the Squeezebox Server user and database.
	einfo "Creating Squeezebox Server MySQL user and database (${DBUSER}) ..."
	sed -e "s/__DATABASE__/${DBUSER}/" -e "s/__DBUSER__/${DBUSER}/" -e "s/__DBPASSWORD__/${DBUSER_PASSWD}/" < "/usr/share/${PN}/SQL/mysql/dbcreate-gentoo.sql" | mysql --user=root --password="${ROOT_PASSWD}" || die "Unable to create MySQL database and user"

	# Remove the existing MySQL preferences from Squeezebox Server (if any).
	sc_remove_db_prefs "${PREFS}"
	[ -f "${LIVE_PREFS}" ] && sc_remove_db_prefs ${LIVE_PREFS}

	# Insert the external MySQL configuration into the preferences.
	sc_update_prefs "${PREFS}" "${DBUSER}" "${DBUSER_PASSWD}"
	[ -f "${LIVE_PREFS}" ] && sc_update_prefs "${LIVE_PREFS}" "${DBUSER}" "${DBUSER_PASSWD}"

	# Phew - all done. Give some tips on what to do now.
	einfo "Database configuration complete."
	einfo ""
	sc_starting_instr
}

# pkg_preinst() {
# 	# Warn the user if there are old plugins that they may need to migrate
# 	if [ -d "${OLDPLUGINSDIR}" ]; then
# 		if [ ! -z "$(ls ${OLDPLUGINSDIR})" ]; then
# 			ewarn "Note: It appears that plugins are installed in the old location of:"
# 			ewarn "${OLDPLUGINSDIR}"
# 			ewarn "If these are to be used then they must be migrated to the new location:"
# 			ewarn "${NEWPLUGINSDIR}"
# 			ewarn ""
# 		fi
# 	fi
# }
