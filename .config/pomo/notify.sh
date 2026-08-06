#!/bin/bash
if [ $1 -eq 1 ]; then
    notify-send " POMO!" "Stop working! Go drink some water!"
else
    notify-send " POMO!" "Back to work!"
fi

paplay $HOME/Music/whiterose.mp3
