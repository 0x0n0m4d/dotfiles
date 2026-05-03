#!/bin/sh

OUT=$(pactl list sinks | grep -e Mute: -e Volume:)

MUTED=$(echo $OUT | head -n 1 | awk '{print $2}')

if [ $MUTED = "yes" ]; then
    VOLUME="muted"
    FG_COLOR="#915001"
    SYMBOL=""
else
    VOLUME=$(echo $OUT | awk '{print $7}')
    SYMBOL=" "
    FG_COLOR="#fc8b02"
fi

echo "<span bgcolor='#000000' color='${FG_COLOR}'> ${SYMBOL} ${VOLUME} </span>\n"
