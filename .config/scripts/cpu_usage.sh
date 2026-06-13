#!/bin/sh

number_to_chinese() {
    case "$1" in
    0) echo "零" ;;
    1) echo "一" ;;
    2) echo "二" ;;
    3) echo "三" ;;
    4) echo "四" ;;
    5) echo "五" ;;
    6) echo "六" ;;
    7) echo "七" ;;
    8) echo "八" ;;
    9) echo "九" ;;
    10) echo "十" ;;
    *)
        if [ "$1" -lt 20 ]; then
            ones=$(($1 % 10))
            ones_cn=$(number_to_chinese "$ones")
            echo "十${ones_cn}"
        else
            tens=$(($1 / 10))
            ones=$(($1 % 10))

            tens_cn=$(number_to_chinese "$tens")

            if [ "$ones" -eq 0 ]; then
                echo "${tens_cn}十"
            else
                ones_cn=$(number_to_chinese "$ones")
                echo "${tens_cn}十${ones_cn}"
            fi
        fi
        ;;
    esac
}

digit_to_chinese() {
    case "$1" in
    0) echo -n "零" ;;
    1) echo -n "一" ;;
    2) echo -n "二" ;;
    3) echo -n "三" ;;
    4) echo -n "四" ;;
    5) echo -n "五" ;;
    6) echo -n "六" ;;
    7) echo -n "七" ;;
    8) echo -n "八" ;;
    9) echo -n "九" ;;
    esac
}

USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%.2f\n", $(NF-9))}')

INT_PART=$(echo "$USAGE" | cut -d '.' -f 1)
DEC_PART=$(echo "$USAGE" | cut -d '.' -f 2)

INT_CN=$(number_to_chinese "$INT_PART")

DEC_CN=""
for digit in $(echo "$DEC_PART" | grep -o .); do
    DEC_CN="${DEC_CN}$(digit_to_chinese "$digit")"
done

echo "${INT_PART}:${INT_CN}点${DEC_CN}％"
