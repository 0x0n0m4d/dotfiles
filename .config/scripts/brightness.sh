#!/bin/sh

MAX_BRIGHT=96000
CURRENT_BRIGHT=$(brightnessctl g)
PERCENTAGE=$(((CURRENT_BRIGHT * 100) / MAX_BRIGHT))

echo "<span bgcolor='#000000' color='#fc8b02'>  ${PERCENTAGE}% </span>"
