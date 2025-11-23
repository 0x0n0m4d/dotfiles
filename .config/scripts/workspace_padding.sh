#!/bin/sh

PADDING=" "

add_padding() {
    jq --unbuffered --compact-output \
        --arg pad "$PADDING" '[ .[] | .name |= ($pad + . + $pad) ]'
}

i3-msg -t subscribe -m '["workspace", "output"]' | {
    i3-msg -t get_workspaces | add_padding

    while read -r event; do
        i3-msg -t get_workspaces | add_padding
    done
}
