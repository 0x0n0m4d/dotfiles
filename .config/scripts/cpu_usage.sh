#!/bin/sh

USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%.2f\n", $(NF-9))}')

echo "${USAGE}"
