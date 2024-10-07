#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <directory> <src extension> <dst extension>"
    exit 1
fi
D_WORK="$1"
SRC=".$2"
DST=".$3"

T_FILE1=/tmp/.tmp1     # tempory file1

find $D_WORK | grep "${SRC}$" > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $FILE $(echo $FILE | sed "s/${SRC}$/${DST}/g")
done
