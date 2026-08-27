#!/bin/sh

OUT=$(pactl list sinks | grep -e Mute: -e Volume:)

MUTED=$(echo "$OUT" | head -n 1 | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    VOLUME="MUTED"
else
    VOLUME=$(echo "$OUT" | grep Volume: | head -n 1 | awk '{print $5}' | tr -d '%')
fi

echo "${VOLUME}"
