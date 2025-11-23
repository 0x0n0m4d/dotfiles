#!/bin/sh

WLAN0=$(ip -4 addr show wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
TUN0=$(ip -4 addr show tun0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
NORDLYNX=$(ip -4 addr show nordlynx 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

BG_COLOR="#fb4934"
if [ ! -z $TUN0 ]; then
    IP="$TUN0"
elif [ ! -z $NORDLYNX ]; then
    IP="$NORDLYNX"
elif [ ! -z $WLAN0 ]; then
    IP="$WLAN0"
else
    IP="0.0.0.0"
fi

echo "<span bgcolor='$BG_COLOR' color='#282828'>  󰀂 $IP  </span>"
