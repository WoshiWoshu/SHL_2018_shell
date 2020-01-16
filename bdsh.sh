#!/bin/bash
##
## EPITECH PROJECT, 2019
## bdsh
## File description:
## shell script
##

FILE=""
CREATE=""
DATA=""
REQUEST=""

usage (){
    echo "Usage: ./bdsh [OPTION]... [COMMAND] [REQUEST]"
}

if [[ "$1" == "-h" ]]; then
    usage
elif [[ "$1" == "-j" ]]; then
     echo "pas de mayonaise pas de ketchup"
elif [[ "$1"  == "-f" ]]; then
     if [ $# > 1 ]; then
         shift
     fi
     FILE=$1
fi
if [ $# > 1 ]; then
    shift
fi

my_create_table() {
    touch tmp
    echo $DATA >> tmp
    sed -i -e 's/,/",\n    "/g' tmp
    DATA=`head tmp`
    rm tmp
    sed -i '$d' $FILE
    sed -i '$d' $FILE
    echo "  ]," >> $FILE
    echo "  \"desc_$CREATE\": [" >> $FILE
    echo "    $DATA" >> $FILE
    echo "  ]" >> $FILE
    echo "}" >> $FILE;
}

my_describe() {
    REQUEST="desc_$REQUEST"
    START_LINE=$(grep -n "$REQUEST" $FILE | cut -d ':' -f 1)
    if [ -z $START_LINE ]; then
        exit 84
    fi
    END_LINE=$(tail -n+$START_LINE $FILE | grep -n "]" | cut -d ':' -f 1 | head -1)
    START_LINE=`expr $END_LINE + 1 `
    END_LINE=`expr $END_LINE - 2 `
    tail -n+$START_LINE $FILE | head -n$END_LINE | sed 's/[", \t] *//g'
}

if [[ "$1" == "create" ]]; then
    if [ -n $2 ]; then
        if [[ "$2" == "database" ]]; then
            if [ -n $3 ]; then
                if [ -f $FILE ]; then
                    echo "[ERROR] File already exist"
                    exit 84
                fi
                touch $FILE
                echo "{" >> $FILE
                echo "}" >> $FILE
                if [ ! -f $FILE ]; then
                    echo "[ERROR] File didn't create correctly"
                    exit 84
                fi
            elif [[ "$2" == "table" ]] && [ -n $3 ] && [ -n $4 ]; then
                CREATE=$3
                DATA="\"$4\""
                my_create_table
            fi
        fi
    fi
elif [[ "$1" == "describe" ]]; then
    if [ -n $2 ]; then
        REQUEST=$2
    else
        echo "[ERROR] bad table argument"
        usage
        exit 84
    fi
    my_describe
fi

#echo $FILE
