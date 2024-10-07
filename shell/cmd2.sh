#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <CMD OPTIOMS ARGS>"
    exit 1
fi
CMD="$*"

SERVERLIST=/root/shell/server.txt
for i in $(cat $SERVERLIST)
do
    echo "---- $i ----"
    ssh "$i" "$CMD"
    echo
done
