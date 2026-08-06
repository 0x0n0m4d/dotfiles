#!/bin/bash
# Fetch the next appointment's description
EVENT="$(calcurse -n | tail -1 | cut -d ' ' -f 5-)"
# Send the notification with the appointment title
notify-send -u low "  Calendar!" "${EVENT}"
paplay $HOME/Music/whiterose.mp3
