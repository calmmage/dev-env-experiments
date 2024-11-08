#!/bin/bash

# defaults read > temp.plist

# Get all domains
domains=$(defaults domains | tr ',' '\n' | sed 's/^ *//')

# Check if output path is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide output path as first argument"
    exit 1
fi

# Create an empty JSON object at specified path
echo "{}" > "$1"

# For each domain
for domain in $domains; do
echo "Processing $domain..."
    # Export the domain's defaults to a temporary file
    defaults export "$domain" - | plutil -convert json -o "temp_$domain.json" -
    
    # If the conversion was successful, add it to our main JSON
    if [ -s "temp_$domain.json" ]; then
        # Use jq to merge the files
        jq --arg domain "$domain" '. + {($domain): input}' "$1" "temp_$domain.json" > "temp_combined.json"
        mv "temp_combined.json" "$1"
    fi
    
    # Clean up temporary file
    rm -f "temp_$domain.json"
done