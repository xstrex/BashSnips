#!/usr/bin/env bash
#
# Fully TTS Script
# @author Strex
#
# Define some variables
port="2323"

# functions
usage () {
  echo "Usage: $0 [ -h host ] [ -p password ] [ -m "message" ]"
}

# Extract options and their args into variables
while getopts ":h:p:m:" o; do
  case "${o}" in
    h)
      host=${OPTARG}
      ;;
    p)
      pass=${OPTARG}
      ;;
    m)
      raw=${OPTARG}
      mesg=${raw// /+}
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [ -z "${host}" ] || [ -z "${pass}" ] || [ -z "${mesg}" ]; then
    usage
fi

# Finally set-up the URL
url="http://${host}:${port}/?cmd=textToSpeech&text=${mesg}&password=${pass}"

# Play our message
curl -s -X POST "${url}" >/dev/null 2>&1

exit 0
