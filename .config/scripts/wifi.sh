#!/bin/sh

INTERFACE="wlan0"
SSID=$(iw dev | grep ssid | awk '{print $2}')

if [ ! -d "/sys/class/net/${INTERFACE}/" ] || [ ! -f "/sys/class/net/${INTERFACE}/operstate" ]; then
    OUTPUT="NO_INT."
elif [ -z "$SSID" ]; then
    OUTPUT="NO_CONN."
else
    SIGNAL=$(iw dev "$INTERFACE" link | grep signal | awk '{print $2}')

    if [ -z "$SIGNAL" ] || [ "$SIGNAL" -le -90 ]; then
        PERCENTAGE=0
    elif [ "$SIGNAL" -gt -30 ]; then
        PERCENTAGE=100
    else
        PERCENTAGE=$((100 * (SIGNAL + 90) / 60))
    fi

    OUTPUT="${PERCENTAGE}"
fi

echo "${OUTPUT}"
