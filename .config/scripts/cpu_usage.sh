#!/bin/bash

USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
FG_COLOR="#8ec07c"
if [ $USAGE -ge 80 ]; then
    FG_COLOR="#fb4934"
fi

echo "<span bgcolor='#282828' color='${FG_COLOR}'>   ${USAGE}%  </span>"
