#!/bin/bash

for VAR in A B C D
do 
    echo $VAR
done

for VAR in {1..10}
do
    echo $VAR
done

# 많이 사용하는 스타일
for VAR in $(seq 1 5)
do
    echo $VAR
done
