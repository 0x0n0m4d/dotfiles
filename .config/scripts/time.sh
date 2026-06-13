#!/bin/bash

number_to_chinese() {
    local num=$1

    digits=("零" "一" "二" "三" "四" "五" "六" "七" "八" "九")

    if [ "$num" -lt 10 ]; then
        echo "${digits[$num]}"
    elif [ "$num" -lt 20 ]; then
        if [ "$num" -eq 10 ]; then
            echo "十"
        else
            echo "十${digits[$((num % 10))]}"
        fi
    else
        tens=$((num / 10))
        ones=$((num % 10))

        if [ "$ones" -eq 0 ]; then
            echo "${digits[$tens]}十"
        else
            echo "${digits[$tens]}十${digits[$ones]}"
        fi
    fi
}

HOUR=$(date '+%H')
MIN=$(date '+%M')

# Remove leading zeros
HOUR=$((10#$HOUR))
MIN=$((10#$MIN))

HOUR_CN=$(number_to_chinese "$HOUR")

if [ "$MIN" -lt 10 ]; then
    MIN_CN="零$(number_to_chinese "$MIN")"
else
    MIN_CN=$(number_to_chinese "$MIN")
fi

echo "${HOUR_CN}点${MIN_CN}分"
