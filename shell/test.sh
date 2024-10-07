#!/bin/bash

DNS=
for i in $(cat /test/file1)
do
	DNS="$DNS $i "
done
echo $DNS
