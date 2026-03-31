#!/bin/sh

MEMORY=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

FG_COLOR="#83a598"
if [ $MEMORY -gt 80 ]; then
    FG_COLOR="#fb4934"
fi

echo "<span bgcolor='#282828' color='${FG_COLOR}'>   ${MEMORY}%  </span>\n"
