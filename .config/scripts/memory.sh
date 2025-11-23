#!/bin/sh

MEMORY=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

BG_COLOR="#83a598"
if [ $MEMORY -gt 80 ]; then
    BG_COLOR="#fb4934"
fi

echo "<span bgcolor='$BG_COLOR' color='#282828'>   $MEMORY%  </span>\n"
