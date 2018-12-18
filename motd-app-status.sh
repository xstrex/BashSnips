#!/usr/bin/env bash

############################################################################
# Purpose: Display the app status of various apps on Linux motd systems
# Directions: Name this file: 10-app-status, place it in: /etc/update-motd.d/
# Requirements: Monit should be setup to monitor the processes
#
# Author: Strex
# Contact: strex@morphx.net
# Version: 0.1
# Date: 12/18/18
############################################################################

###############
# Variables
app1=named
app2=lighttpd
app3=mmonit

###############
# Functions

###############
# Terminator
# Add additional if's for additional app#'s
if [ $(monit status "$app1" | grep status | head -1 | awk '{print $2}') == "OK" ]; then
        echo "${app1^}" is: ONLINE
else
        echo "${app1^}" is:  OFFLINE
fi

if [ $(monit status "$app2" | grep status | head -1 | awk '{print $2}') == "OK" ]; then
        echo "${app2^}" is: ONLINE
else
        echo "${app2^}" is:  OFFLINE
fi

if [ $(monit status "$app3" | grep status | head -1 | awk '{print $2}') == "OK" ]; then
        echo "${app3^}" is: ONLINE
else
        echo "${app3^}" is:  OFFLINE
fi

echo
