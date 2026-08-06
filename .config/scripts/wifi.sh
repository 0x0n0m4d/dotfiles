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

INTERFACE="wlan0"
SSID=$(iw dev | grep ssid | awk '{print $2}')

if [ ! -d "/sys/class/net/${INTERFACE}/" ] || [ ! -f "/sys/class/net/${INTERFACE}/operstate" ]; then
    OUTPUT=" 无网络"
elif [ -z "$SSID" ]; then
    OUTPUT="󱛂 未连接"
else
    SIGNAL=$(iw dev "$INTERFACE" link | grep signal | awk '{print $2}')

    if [ -z "$SIGNAL" ] || [ "$SIGNAL" -le -90 ]; then
        PERCENTAGE=0
    elif [ "$SIGNAL" -gt -30 ]; then
        PERCENTAGE=100
    else
        PERCENTAGE=$((100 * (SIGNAL + 90) / 60))
    fi

    PERCENTAGE_CN=$(number_to_chinese "$PERCENTAGE")

    OUTPUT="󰖩 ${PERCENTAGE_CN}％"
fi

echo "<span color='#282828' bgcolor='#fb4934'> ${OUTPUT}  </span>"
