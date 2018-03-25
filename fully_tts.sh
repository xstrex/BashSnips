#!/usr/bin/env bash
#
# Fully TTS Script
# @author Strex
#
# /usr/bin/curl -k "http://n7x1:2323/?cmd=textToSpeech&text=message&password=pass" > /dev/null
#
# Define some variables
curl=`which curl`
sed=`which sed`
cat=`which cat`

# Host info
# host=$1
# pass=pass

# Swap " " for "+" in message
FOO=`getopt -o h:m: --long host:,mesg: -n 'fully_tts.sh' -- "$#"`
eval set -- "$FOO"

# functions
usage () {
  printf "%sUsage: fully_tts.sh [ -h | --host ] [ -m | --mesg ]\n"
}

# if [ $# -ne "2" ]; then
#   usage
# fi

# Extract options and their args into variables
while true ; do
    case "$1" in
      -h|--host)
        case "$2" in
            "") shift 2 ;;
            *) HOST=$2 ; shift 2 ;;
        esac ;;
      -m|--mesg)
        case "$2" in
            "") shift 2 ;;
            *) MESG=$2 ; shift 2 ;;
        esac ;;
      --) shift ; break ;;
      *) usage ; exit 1 ;;
    esac
done

echo "host is: $HOST"
echo "message is: $MESG"
