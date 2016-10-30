#!/bin/bash

# Set default values for variables
ADDRESS=127.0.0.1
PORT=9999
DICTIONARY=/usr/share/dict/words
MAXWORDS=50
SLEEPPERIOD=0.7
VERBOSE=false

function help {
  cat << EOF
usage: $0 [options]

OPTIONS:
  -a  Address (default 127.0.0.1)
  -d  Textfile containing words (default /usr/share/dict/words)
  -p  Port to send to (default 9999)
  -s  Sleep period (default 0.7 seconds)

  -h  Show help
  -v  Verbose mode
EOF
exit 1
}

while getopts "a:d:p:s:hv" ARGS; do
  case $ARGS in
    a) ADDRESS=${OPTARG} ;;
    d) DICTIONARY=${OPTARG} ;;
    p) PORT=${OPTARG} ;;
    s) SLEEPPERIOD=${OPTARG} ;;
    h) help ; exit 1 ;;
    v) VERBOSE=true; echo "Verbose mode on." ;;
    *) help ;;
    \? ) echo "Invalid Option: -$OPTARG" 1>&2 ; exit 1 ;;
  esac
done
shift $((OPTIND-1))

if $VERBOSE; then
  echo "address = $ADDRESS"
  echo "dictionary = $DICTIONARY"
  echo "port = $PORT"
  echo "sleepperiod = $SLEEPPERIOD"
fi

while true;
do
    n=`jot -r 1 1 $MAXWORDS`
    randomsentence=`gshuf -n$n $DICTIONARY | tr '\n' ' ' | awk -F"\n" "{print}"`
    if $VERBOSE; then echo $randomsentence; fi
    echo $randomsentence | nc $ADDRESS $PORT
    sleep $SLEEPPERIOD
done
