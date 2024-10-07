#!/bin/bash

# HOSTS=/etc/hosts
HOSTS=/root/shell/hosts
NET=172.16.6

for i in $(seq 200 230)
do
    # echo $i
    echo "$NET.$i   linux$i.example.com linux$i" >> $HOSTS
done


