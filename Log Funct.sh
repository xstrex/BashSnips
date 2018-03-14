#!/bin/bash

# Simple logging function for shell scripts
#
# Variables
SCRIPT="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
SBASE=${SCRIPT%%.*}
DATE=$(date +"%m-%d-%Y %H:%M:%S")
SDATE=$(date +"%m-%d-%Y")
LOG="$SDATE-$SBASE.log"

# Logging Function
log () {
        echo "$DATE $1" >> $LOG
}