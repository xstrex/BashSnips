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

TIME=$(xpath "$1" '/gpx/metadata/time/text()' 2>/dev/null | cut -d. -f 1 |awk -F "T" '{print $2 " " $1}')
NAME=$(xpath "$1" '/gpx/trk/name/text()' 2>/dev/null)
CORD=$(xpath "$1" '/gpx/trk/trkseg/trkpt[1]' 2>/dev/null |grep -e "<trkpt " | gsed -re 's/<trkpt |>//g')

echo "$NAME"
echo "$TIME"
echo "$CORD"