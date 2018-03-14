#!/bin/bash

# Grab RHEL or OEL release info from servers
release () {
	if [ -e "/etc/redhat-release" ]; then
	REL=`grep -Eo '[0-9].[0-9]' /etc/redhat-release`
	echo "RHEL $REL"
	elif [ -e "/etc/oracle-release" ]; then
	OEL=`grep -Eo '[0-9].[0-9]' /etc/oracle-release`
	echo "OEL $OEL"
	else
	echo "Not RHEL or OEL"
	fi
}

release