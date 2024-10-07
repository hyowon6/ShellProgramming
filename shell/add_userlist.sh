#!/bin/bash

USERLIST=/root/shell/user.list
> $USERLIST

for i in $(seq 50 100)
do
    echo "user$i    user$i" >> $USERLIST
done


