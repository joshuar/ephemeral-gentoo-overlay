# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Lots of thanks to Stuart Hickinbottom and his work in getting Squeezebox ebuilds
# into the official Gentoo tree, some of which has been stolen for these ebuilds ;)

EAPI=2

inherit eutils

MAJOR_VER="${PV:0:3}"
MINOR_VER="${PV:4:1}"
# REVISION=${PV#${MAJOR_VER}.${MINOR_VER}_rc}
# MY_P="${PN}-${MAJOR_VER}.${MINOR_VER}-${REVISION}-noCPAN"
MY_P="${PN}-${PV}-noCPAN"
MY_REV=30464

DESCRIPTION="Logitech SqueezeboxServer music server"
HOMEPAGE="http://www.logitechsqueezebox.com/support/download-squeezebox-server.html"
SRC_URI="http://downloads.slimdevices.com/SqueezeboxServer_v7.5.0/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lame wavpack logrotate alac ogg +flac aac"

DEPEND=">=dev-perl/AnyEvent-5.2.3
>=dev-perl/Audio-Scan-0.62
>=dev-perl/Cache-Cache-1.04
>=virtual/perl-CGI-3.48
>=dev-perl/Class-Data-Inheritable-0.04
>=dev-perl/Class-Inspector-1.16
>=dev-perl/Data-URIEncode-0.11
>=dev-perl/DBD-mysql-3.002
>=dev-perl/DBIx-Class-0.08109
>=dev-perl/EV-3.8
>=dev-perl/File-BOM-0.13
>=dev-perl/File-Next-1.02
>=virtual/perl-File-Temp-0.17
>=dev-perl/File-Which-0.05
>=dev-perl/GD-2.41[jpeg,png]
>=dev-perl/HTML-Parser-3.60
>=perl-core/i18n-langtags-0.35
>=dev-perl/IO-String-1.07
>=dev-perl/JSON-XS-2.2.3
>=dev-perl/JSON-XS-VersionOneAndTwo-0.31
>=dev-perl/Log-Log4perl-1.23
>=dev-perl/Math-VecStat-0.08
>=dev-perl/Path-Class-0.16
>=dev-perl/Proc-Background-1.08
>=dev-perl/SQL-Abstract-1.56
>=dev-perl/Sub-Name-0.04
>=dev-perl/Text-Unidecode-0.04
>=dev-perl/Tie-Cache-LRU-20081023.2116
>=dev-perl/Tie-LLHash-1.003
>=dev-perl/Tie-RegexpHash-0.13
>=dev-perl/TimeDate-1.20
>=dev-perl/URI-1.35
>=dev-perl/XML-Parser-2.36
>=dev-perl/XML-Simple-2.15
>=dev-perl/YAML-Syck-1.05
>=dev-perl/Algorithm-C3-0.07
>=dev-perl/Archive-Zip-1.29
>=dev-perl/Carp-Assert-0.18
>=dev-perl/Carp-Clan-5.3
>=dev-perl/Class-Accessor-0.31
>=dev-perl/Class-C3-0.21
>=dev-perl/Class-ISA-0.33
>=dev-perl/Class-Member-1.6
>=dev-perl/Class-Singleton-1.3
>=dev-perl/Class-Virtual-0.05
>=dev-perl/Class-XSAccessor-1.05
>=dev-perl/common-sense-2.01
>=virtual/perl-Compress-Raw-Zlib-2.017
>=dev-perl/Data-Dump-1.06
>=dev-perl/Data-Page-2.00
>=dev-perl/DBI-Shell-11.93
>=dev-perl/DBI-1.609
>=dev-perl/Devel-Leak-Object-0.92
>=virtual/perl-digest-base-1.00
>=virtual/perl-Digest-SHA-2.11
>=dev-perl/Data-UUID-1.202
>=dev-perl/Encode-Detect-1.00
>=dev-perl/enum-1.016
>=dev-perl/Error-0.15.008
>=dev-perl/Exporter-Lite-0.01
>=dev-perl/File-Copy-Recursive-0.38
>=dev-perl/File-ReadBackwards-1.04
>=dev-perl/File-Slurp-9999.09
>=virtual/perl-File-Spec-3.12
>=dev-perl/File-Which-0.05
>=dev-perl/HTML-Format-2.04
>=dev-perl/HTML-Tree-3.23
>=dev-perl/Imager-0.67
>=virtual/perl-IO-Compress-2.015
>=dev-perl/Module-Find-0.06
>=dev-perl/MRO-Compat-0.10
>=dev-perl/Net-UPnP-1.2.1
>=dev-perl/PAR-Dist-0.21
>=dev-perl/PAR-0.970
>=dev-perl/Path-Class-0.16
>=dev-perl/Readonly-1.03
>=dev-perl/Scope-Guard-0.03
>=dev-perl/SQL-Abstract-Limit-0.14.1
>=dev-perl/Template-Toolkit-2.21
>=dev-perl/Template-DBI-2.63
>=dev-perl/Template-GD-2.66
>=dev-perl/Template-XML-2.17
>=virtual/perl-Test-Simple-0.62
>=dev-perl/Text-Glob-0.06
>=dev-perl/Text-Unidecode-0.04
>=dev-perl/Tie-Cache-LRU-Expires-0.54
>=dev-perl/Tie-IxHash-1.21
>=dev-perl/perl-tk-804.028
>=dev-perl/URI-Find-20090319
>=dev-perl/UUID-Tiny-1.01
>=virtual/perl-version-0.74
>=dev-perl/XML-NamespaceSupport-1.08
>=dev-perl/XML-SAX-0.12
>=dev-perl/XML-Writer-0.600
>=dev-perl/XML-XSPF-0.5
>=dev-perl/yaml-0.68
>=dev-perl/Audio-Musepack-0.7
>=dev-perl/Class-Accessor-Grouped-0.08004
>=dev-perl/log-dispatch-2.22
>=dev-perl/MP3-Info-1.24
>=dev-perl/MPEG-Audio-Frame-0.09
!dev-perl/DBIx-Migration
lame? ( media-sound/lame )
alac? ( media-sound/alac_decoder )
wavpack? ( media-sound/wavpack )
flac? (
	media-libs/flac
	media-sound/sox[flac]
)
ogg? ( media-sound/sox[ogg] )
aac? ( media-libs/faad2 )
"
RDEPEND="${DEPEND}"

DOCS="Changelog*.html License.txt ${FILESDIR}/Gentoo-plugins-README.txt"
PREFS=/var/lib/${PN}/prefs/${PN}.prefs
LIVE_PREFS=/var/lib/${PN}/prefs/server.prefs
SBS_USER="squeezeboxserver"
SBS_GROUP="squeezeboxserver"
DBUSER=${PN}

S="${WORKDIR}/${PN}-${PV}-${MY_REV}-noCPAN"

pkg_setup() {
	# Create the user and group if not already present
	enewgroup ${SBS_GROUP}
	enewuser ${SBS_USER} -1 -1 "/dev/null" ${SBS_USER}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply patches
	epatch "${FILESDIR}/${P}-uuid-gentoo.patch"
	epatch "${FILESDIR}/${P}-squeezeslave.patch"
}


src_install() {
	# The main Perl executables
	newsbin slimserver.pl ${PN}-server
	newsbin slimservice.pl ${PN}-service
	newsbin scanner.pl ${PN}-scanner
	newsbin cleanup.pl ${PN}-cleanup

	# Get the Perl package name and version
	eval `perl '-V:package'`
	eval `perl '-V:version'`
	# The server Perl modules
	insinto /usr/lib/${package}/vendor_perl/${version}
	doins -r Slim
	# The custom OS module for Gentoo - provides OS-specific path details
	insinto /usr/lib/${package}/vendor_perl/${version}/Slim/Utils/OS
	newins "${FILESDIR}/gentoo-filepaths-${MAJOR_VER}.pm" Custom.pm

	# Various directories of architecture-independent static files
	insinto /usr/share/${PN}
	doins -r Firmware Graphics HTML IR SQL strings.txt revision.txt slimservice-strings.txt
	# Install the SQL configuration scripts as well
	insinto /usr/share/${PN}/SQL/mysql
	doins "${FILESDIR}/dbdrop-gentoo.sql" "${FILESDIR}/dbcreate-gentoo.sql"

	# Squeezebox Server devs have their own customised version of a few Perl
	# modules that does a few things different than the versions found on
	# CPAN. The standard versions of the modules cause the Squeezebox Server
	# trouble. So assume the Squeezebox Server devs know what they are doing.
	#
	# Notes:
	# - Dirs containing outdated bundled modules:
	#   Audio Cache CGI Class MP3 Template
	insinto "/usr/lib/${PN}"
	doins -r lib/{DBIx,AnyEvent}

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
	newinitd "${FILESDIR}/${PN}.init.d-${MAJOR_VER}" ${PN} \
		or die "Failed to install init.d script."

	# Initialize run directory (where the PID file lives)
	dodir /var/run/${PN}
	fowners ${SBS_USER}:${SBS_GROUP} /var/run/${PN}
	fperms 770 /var/run/${PN}

	# Initialize server cache directory
	# dodir /var/cache/${PN}
	# fowners ${SBS_USER}:${SBS_GROUP} /var/cache/${PN}
	# fperms 770 /var/cache/${PN}
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
	dodir /var/lib/${PN}/Plugins
	fowners ${SBS_USER}:${SBS_GROUP} /var/lib/${PN}/Plugins

	# Documentation
	dodoc ${DOCS}

	# Install logrotate support
	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/${PN}.logrotate.d" ${PN}
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

	elog ""
	sc_starting_instr

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
