#!/bin/bash

hasCon=$(iwconfig wlan0 | head -n 1 | awk -F: '{print $2}' | cut -d"\"" -f2)

if [[ $hasCon = "no wireless extensions." || $(iwconfig wlan0 | grep "off/any" | wc -c) -gt 0 ]]; then
    echo -n "%{F#fb4934}󰤭 %{F-}"
else
    bitRate=$(iwconfig wlan0 | grep Bit | awk -F= '{print $2}' | awk '{print $1}')
    if (($(echo "$bitRate < 20" | bc -l))); then
        echo -n "%{F#d3869b}󰤯 $bitRate Mb/s%{F-}"
    elif (($(echo "$bitRate < 70" | bc -l))); then
        echo -n "%{F#d3869b}󰤟 $bitRate Mb/s%{F-}"
    elif (($(echo "$bitRate < 125" | bc -l))); then
        echo -n "%{F#d3869b}󰤢 $bitRate Mb/s%{F-}"
    elif (($(echo "$bitRate < 200" | bc -l))); then
        echo -n "%{F#d3869b}󰤥 $bitRate Mb/s%{F-}"
    else
        echo -n "%{F#d3869b}󰤨 $bitRate Mb/s%{F-}"
    fi
fi
