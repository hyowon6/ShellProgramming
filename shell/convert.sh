#!/bin/bash

INPUTFILE=/share/output.txt
OUTPUTFILE=/share/output.csv
> $OUTPUTFILE  # outputfile 파일을 비워놓고 시작

cat $INPUTFILE | while read ID NAME EMAIL PHONE ADDR # 나머지 내용을 주소로 받음
do
    #echo $(echo "$LINE") | sed 's/ /,/g'  # tab -> space 1 -> ,
    echo "$ID,$NAME,$EMAIL,$PHONE,$ADDR" >> $OUTPUTFILE
done

cat $OUTPUTFILE
