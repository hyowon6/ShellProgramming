#!/bin/bash

USERLIST=/root/shell/user.list

cat $USERLIST | while read UNAME UPASS
do
    useradd "$UNAME"
    echo "$UPASS" | passwd --stdin "$UNAME"
done

