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

STATUS=$(cat /sys/class/power_supply/BAT1/uevent | grep 'STATUS=' | awk -F= '{print $2}')
PERCENTAGE=$(cat /sys/class/power_supply/BAT1/uevent | grep 'CAPACITY=' | awk -F= '{print $2}')

PERCENTAGE_CN=$(number_to_chinese "$PERCENTAGE")

if [ "$STATUS" = "Discharging" ]; then
    if [ ! -f /tmp/battery_notify.tmp ] && [ "$PERCENTAGE" -le 40 ]; then
        notify-send -u critical "󰁹 电池警告" "电量低，请立即充电！"
        touch /tmp/battery_notify.tmp
    fi
else
    if [ -f /tmp/battery_notify.tmp ]; then
        rm /tmp/battery_notify.tmp
    fi
fi

echo -n "${STATUS}:${PERCENTAGE}:${PERCENTAGE_CN}％"
