#!/bin/bash

USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
BG_COLOR="#8ec07c"
if [ $USAGE -ge 80 ]; then
    BG_COLOR="#fb4934"
fi

echo "<span bgcolor='$BG_COLOR' color='#282828'>   ${USAGE}%  </span>"
