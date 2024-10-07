#!/bin/bash

# Variable definition
NUM=1
BASEDIR=$HOME/scripts/project1
TOTAL_NUM=$(wc -l < $BASEDIR/question/answer.txt)
TMP1=/tmp/tmp1

# Functions definition
ProbView() {
    echo
    cat $1
    echo
}

# Main function
ls -1 $BASEDIR/question/question*.txt > $TMP1
while [ $NUM -le $TOTAL_NUM ]
do
    PROB_FILE=$BASEDIR/question/question$NUM.txt
    ProbView $PROB_FILE
    CORRECT_NUM=$(cat $BASEDIR/question/answer.txt \
                    | sed -n "${NUM}p" \
                    | awk -F: '{print $2}' )
    # echo $CORRECT_NUM
    echo -n "정답은? (1|2|3|4): "
    read ANSWER

    if [ "$ANSWER" = "$CORRECT_NUM" ]; then
        echo "[  OK  ]: 정답입니다."
        NUM=$(expr $NUM + 1)
    else
        echo "[ FAIL ]: 틀렸습니다. 다시시도하시죵~~"
    fi
done

echo
echo "[  OK  ]: 합격하셨습니다." | boxes -d santa
echo 
