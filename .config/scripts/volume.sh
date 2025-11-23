#!/bin/sh

OUT=$(pactl list sinks | grep -e Mute: -e Volume:)

MUTED=$(echo $OUT | head -n 1 | awk '{print $2}')

if [ $MUTED = "yes" ]; then
    VOLUME="muted"
    BG_COLOR="#fb4934"
    SYMBOL=""
else
    VOLUME=$(echo $OUT | awk '{print $7}')
    SYMBOL=" "
    BG_COLOR="#fe8019"
fi

echo "<span bgcolor='$BG_COLOR' color='#282828'>  $SYMBOL $VOLUME  </span>\n"
