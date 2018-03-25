#!/usr/bin/env bash
#
# Fully TTS Script
# @author Strex
#
# /usr/bin/curl -k "http://n7x1:2323/?cmd=textToSpeech&text=message&password=pass" > /dev/null
#
# Define some variables
# curl=`which curl`
# sed=`which sed`
# cat=`which cat`

# Host info
# host=$1
# pass=pass

# functions
usage () {
  printf "%sUsage: $0 [ -h | --host ] [ -m | --mesg ]\n"
}

# Extract options and their args into variables
while getopts ":h:m:" o; do
  case "${o}" in
    h)
      host=${OPTARG}
      ;;
    m)
      mesg=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${h}" ] || [ -z "${m}" ]; then
    usage
fi

echo "host: ${host}"
echo "mesg: ${mesg}"
