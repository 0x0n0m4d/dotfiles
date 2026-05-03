#!/bin/bash

USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
FG_COLOR="#fc8b02"
if [ $USAGE -ge 70 ]; then
    FG_COLOR="#915001"
fi

echo "<span bgcolor='#000000' color='${FG_COLOR}'>  ${USAGE}% </span>"
