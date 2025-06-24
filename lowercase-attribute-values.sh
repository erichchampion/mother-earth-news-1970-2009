#!/bin/bash

# Find all .htm files
find . -type f -name "*.htm" | while IFS= read -r file; do
    echo "Processing: $file"
    cp "$file" "$file.bak"  # Optional backup

    # Use Perl to lowercase all href/src attribute values
    perl -pi -e '
        s/(href|src)="(.*?)"/$1 . "=\"" . lc($2) . "\""/ge
    ' "$file"
done
