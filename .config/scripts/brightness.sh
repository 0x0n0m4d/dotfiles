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
    100) echo "一百" ;;
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

MAX_BRIGHT=96000
CURRENT_BRIGHT=$(brightnessctl g)
PERCENTAGE=$(((CURRENT_BRIGHT * 100) / MAX_BRIGHT))

PERCENTAGE_CN=$(number_to_chinese "$PERCENTAGE")

echo "<span color='#282828' bgcolor='#d79921'> 󰌵 ${PERCENTAGE_CN}％  </span>"
