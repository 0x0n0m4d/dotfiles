#!/bin/bash

# colors
RED='\033[0;41m'
YELLOW='\033[0;103m'
BLUE='\033[0;44m'
NC='\033[0m'

percentage=$(acpi | awk -F, '{print $2}' | awk -F% '{print $1}' | sed 's/ //g')

test $(acpi | awk -F, '{print $1}' | awk -F: '{print $2}' | sed 's/ //g') = "Charging"
isCharging=$?

sendNotification() {
    notify-send -u critical "$percentage% battery remaining!!"
}

main() {
    if [ $isCharging -eq 0 ]; then
        echo -n "%{F#8ec07c} ${percentage}%%{F-}"
    else
        if [ $percentage -lt 21 ]; then
            if [[ $percentage -eq 20 ]]; then
                sendNotification
            fi
            echo -n "%{F#fb4934} ${percentage}%%{F-}"
        elif [ $percentage -lt 36 ]; then
            echo -n "%{F#b8bb26} ${percentage}%%{F-}"
        elif [ $percentage -lt 51 ]; then
            echo -n "%{F#b8bb26} ${percentage}%%{F-}"
        elif [ $percentage -lt 71 ]; then
            echo -n "%{F#b8bb26} ${percentage}%%{F-}"
        else
            echo -n "%{F#b8bb26} ${percentage}%%{F-}"
        fi
    fi
}

main
