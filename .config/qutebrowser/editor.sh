#!/bin/bash

#!/bin/sh
# Usage: editor.sh <file>
file="$1"

# view-source content is HTML; url editing is a one-line file.
# Decide by line count instead of changing qutebrowser config.
if [ "$(wc -l < "$file")" -gt 3 ]; then
    editor="vim"
    class="qutebrowser-source"
else
    editor="vim"
    class="qutebrowser-url"
fi

exec kitty --class "$class" --title "$class" -- "$editor" "$file"
