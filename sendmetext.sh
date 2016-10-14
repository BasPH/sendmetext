#!/bin/bash

address=${1:-127.0.0.1}
port=${2:-9999}
dictionary=${3:-/usr/share/dict/words}
maxwords=${4:-50}
sleepperiod=${5:-0.7}

while true;
do
    n=`jot -r 1 1 $maxwords`
    gshuf -n$n $dictionary | tr '\n' ' ' | awk -F"\n" "{print}" | nc $address $port
    sleep $sleepperiod
done
