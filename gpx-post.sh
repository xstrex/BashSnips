#!/usr/bin/env bash
#
#
# Generate a Dokuwiki post from a gpx file
# @author Strex
#
# xpath 12312017.gpx '/gpx/metadata/time' | gsed -re 's/<\/?\w+>//g'
#
# Functions
############
usage () {
	echo "Usage: $0 [ gpx files ]"
}

if [[ $# == '0' ]]; then
	usage
	return 0
fi

TIME=$(xpath "$1" '/gpx/metadata/time/text()' 2>/dev/null)

echo $TIME