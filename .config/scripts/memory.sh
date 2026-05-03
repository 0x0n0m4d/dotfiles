#!/bin/sh

MEMORY=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

FG_COLOR="#fc8b02"
if [ $MEMORY -gt 80 ]; then
    FG_COLOR="#915001"
fi

echo "<span bgcolor='#000000' color='${FG_COLOR}'>  ${MEMORY}% </span>\n"
