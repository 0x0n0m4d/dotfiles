#!/bin/bash

# colors
RED='\033[0;41m'
YELLOW='\033[0;103m'
BLUE='\033[0;44m'
NC='\033[0m'

percentage=$(acpi | awk -F, '{print $2}' | awk -F% '{print $1}' | sed 's/ //g')

test $(acpi | awk -F, '{print $1}' | awk -F: '{print $2}' | sed 's/ //g') = "Charging"
isCharging=$?

if [ $isCharging -eq 0 ]; then
    echo -n "%{F#83a598}%{F-}%{B#83a598}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#83a598}%{F-}"
else
    if [ $percentage -lt 20 ]; then
        echo -n "%{F#fb4934}%{F-}%{B#fb4934}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#fb4934}%{F-}"
    elif [ $percentage -lt 31 ]; then
        echo -n "%{F#fabd2f}%{F-}%{B#fabd2f}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#fabd2f}%{F-}"
    elif [ $percentage -lt 51 ]; then
        echo -n "%{F#fabd2f}%{F-}%{B#fabd2f}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#fabd2f}%{F-}"
    elif [ $percentage -lt 71 ]; then
        echo -n "%{F#458588}%{F-}%{B#458588}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#458588}%{F-}"
    else
        echo -n "%{F#458588}%{F-}%{B#458588}%{F#141617}   ${percentage}% %{B-}%{F-}%{F#458588}%{F-}"
    fi
fi
