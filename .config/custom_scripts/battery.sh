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
    echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    if [ $(cat .sendnotification.out) -eq 1 ]; then
      echo -n 0 >.sendnotification.out
    fi
  else
    if [ $percentage -lt 21 ]; then
      if [[ $percentage -eq 20 ]]; then
        if [ $(cat .sendnotification.out) -eq 0 ]; then
          sendNotification
          echo -n 1 >.sendnotification.out
        fi
      fi
      echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    elif [ $percentage -lt 36 ]; then
      echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    elif [ $percentage -lt 51 ]; then
      echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    elif [ $percentage -lt 71 ]; then
      echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    else
      echo -n "%{B#adb8b8} %{F#00141a} ${percentage}%%{F-} %{B-}"
    fi
  fi
}

if [ ! -e .sendnotification.out ]; then
  echo -n 0 >.sendnotification.out
fi
main
