#!/bin/bash

FILE="$1"

if [[ -z "$FILE" ]]; then
    echo "This script renormalizes a file until its SHA256 hash stops changing, ensuring proper normalization."
    echo "Usage: $0 <file_path>"
    exit 1
fi

while true; do
    ORIGINAL_HASH=$(sha256sum "$FILE" | awk '{print $1}')
    
    git add --renormalize "$FILE" && git add "$FILE"
    
    NEW_HASH=$(sha256sum "$FILE" | awk '{print $1}')
    
    if [[ "$ORIGINAL_HASH" == "$NEW_HASH" ]]; then
        break
    fi
done
