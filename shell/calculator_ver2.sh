#!/bin/bash

Error() {
    echo "[ FAIL ]: 잘못된 $OP를 입력했습니다."
    exit 2
}

# Enter A : 5
echo -n "Enter A: "
read A

# Enter Operator : +
echo -n "OP     : "
read OP

#Enter C : 3
echo -n "Enter B: "
read B

# 5 + 3 = 8
case $OP in
    '+') echo "$A + $B = $(expr $A + $B)" ;;
    '-') echo "$A - $B = $(expr $A - $B)" ;;
    '*') echo "$A x $B = $(expr $A \* $B)" ;;
    '/') echo "$A / $B = $(expr $A / $B)" ;;
    *) Error ;;
esac


