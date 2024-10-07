#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <IP1> <IP2>"
    exit 1
fi
SERVER="$1"
REMOTE="$2"

export LANG=en_US.UTF-8

TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3

ssh "$SERVER" systemctl -t service \
    | grep -v '^●' \
    | awk '{print $1, $3}' \
    | sed -n '2,/^LOAD/p' \
    | sed '$d' > $TMP1

ssh "$SERVER" systemctl -t service \
    | grep '●' \
    | awk '{print $2, $4}' >> $TMP1

ssh "$REMOTE" systemctl -t service \
    | grep -v '^●' \
    | awk '{print $1, $3}' \
    | sed -n '2,/^LOAD/p' \
    | sed '$d' > $TMP2

ssh "$REMOTE" systemctl -t service \
    | grep '●' \
    | awk '{print $2, $4}' >> $TMP2

diff $TMP1 $TMP2 > $TMP3

echo "----- $SERVER -----"
cat $TMP3 | fgrep '<' | cut -c3-
echo

echo "----- $REMOTE -----"
cat $TMP3 | fgrep '>' | cut -c3-
echo
