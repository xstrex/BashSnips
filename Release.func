#!/bin/bash
#
# Grab RHEL or OEL release info from servers
ver () {
	if [ -e "/etc/oracle-release" ]; then
		OS=`cat /etc/oracle-release | cut -d ' ' -f1,2,3`
		VERV=`cat /etc/oracle-release | cut -d ' ' -f5`
	elif [ -e "/etc/redhat-release" ]; then
		OS=`cat /etc/redhat-release | cut -d ' ' -f1,2,3,4`
		VERV=`cat /etc/redhat-release | cut -d ' ' -f7`
	else
	echo "Not RHEL or OEL"
	fi

	if [ -e "/bin/uname" ]; then
		VERR=`uname -r |sed 's/.x86.*//g'`
	elif [ -e "/proc/version" ]; then
		VERR=`cat /proc/version | cut -d ' ' -f3`
	fi

	printf "%s$OS\n$VERV ($VERR)\n"
}
