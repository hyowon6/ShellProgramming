#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
FILENAME=$1

FILESIZE=$(wc -c < $FILENAME)
# echo $FILESIZE
if [ "$FILESIZE" -ge 5120 ]; then
    echo "[ INFO ] $FILENAME($FILESIZE): Big file."
else
    echo "[ INFO ] $FILENAME($FILESIZE): Small file."
fi