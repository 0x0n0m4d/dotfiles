#!/bin/sh

STATUS=$(cat /sys/class/power_supply/BAT1/uevent | grep 'STATUS=' | awk -F= '{print $2}')
PERCENTAGE=$(cat /sys/class/power_supply/BAT1/uevent | grep 'CAPACITY=' | awk -F= '{print $2}')

if [ $STATUS = "Discharging" ]; then
    FG_COLOR="#b8bb26"
    if [ $PERCENTAGE -gt 80 ]; then
        SYMBOL=""
    elif [ $PERCENTAGE -gt 50 ]; then
        SYMBOL=""
    elif [ $PERCENTAGE -gt 30 ]; then
        SYMBOL=""
    elif [ $PERCENTAGE -gt 20 ]; then
        SYMBOL=""
    else
        SYMBOL=""
        FG_COLOR="#fb4934"
    fi
else
    SYMBOL=""
    FG_COLOR="#8ec07c"
fi

echo "<span bgcolor='#282828' color='${FG_COLOR}'>  ${SYMBOL} ${PERCENTAGE}%  </span>"
