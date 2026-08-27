#!/bin/sh

STATUS=$(cat /sys/class/power_supply/BAT1/uevent | grep 'STATUS=' | awk -F= '{print $2}')
PERCENTAGE=$(cat /sys/class/power_supply/BAT1/uevent | grep 'CAPACITY=' | awk -F= '{print $2}')

if [ $STATUS = "Charging" ]; then
    CHARGING=1
else
    CHARGING=0
fi

echo "${CHARGING}:${PERCENTAGE}"
