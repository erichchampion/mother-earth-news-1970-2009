#!/bin/bash

# Function to safely rename a file or directory to lowercase
rename_to_lowercase() {
    local SRC="$1"
    local DIR
    local BASE
    local LOWER
    local TEMP

    DIR=$(dirname "$SRC")
    BASE=$(basename "$SRC")
    LOWER=$(echo "$BASE" | tr '[:upper:]' '[:lower:]')

    # Only proceed if the name needs changing
    if [[ "$BASE" != "$LOWER" ]]; then
        DEST="$DIR/$LOWER"
        # If destination is same as source due to case-insensitive FS, use a temp name
        if [[ "$DEST" == "$SRC" ]]; then
            TEMP="$DIR/temp_$$"
            mv "$SRC" "$TEMP" && mv "$TEMP" "$DEST"
        else
            mv "$SRC" "$DEST"
        fi
    fi
}

# First rename directories (deepest first)
find . -depth -type d | while IFS= read -r d; do
    rename_to_lowercase "$d"
done

# Then rename files
find . -depth -type f | while IFS= read -r f; do
    rename_to_lowercase "$f"
done
