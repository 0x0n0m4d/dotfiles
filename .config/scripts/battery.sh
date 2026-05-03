#!/bin/sh

STATUS=$(cat /sys/class/power_supply/BAT1/uevent | grep 'STATUS=' | awk -F= '{print $2}')
PERCENTAGE=$(cat /sys/class/power_supply/BAT1/uevent | grep 'CAPACITY=' | awk -F= '{print $2}')

if [ $STATUS = "Discharging" ]; then
    FG_COLOR="#fc8b02"
    if [ $PERCENTAGE -gt 80 ]; then
        SYMBOL=""
    elif [ $PERCENTAGE -gt 50 ]; then
        SYMBOL=""
    elif [ $PERCENTAGE -gt 30 ]; then
        SYMBOL=""
        if [ ! -f /tmp/battery_notify.tmp -a $PERCENTAGE -eq 40 ]; then
            notify-send -u critical "󰁹 Battery!!" "Battery low. Charge now!!"
            touch /tmp/battery_notify.tmp
        fi
    elif [ $PERCENTAGE -gt 20 ]; then
        SYMBOL=""
    else
        SYMBOL=""
        FG_COLOR="#915001"
    fi
else
    SYMBOL=""
    FG_COLOR="#fc8b02"
    if [ -f /tmp/battery_notify.tmp]; then
        rm /tmp/battery_notify.tmp
    fi
fi

echo "<span bgcolor='#000000' color='${FG_COLOR}'> ${SYMBOL} ${PERCENTAGE}% </span>"
