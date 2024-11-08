#!/bin/bash

# defaults read > temp.plist

# Get all domains
domains=$(defaults domains | tr ',' '\n' | sed 's/^ *//')

# Create an empty JSON object
echo "{}" > all_defaults.json

# For each domain
for domain in $domains; do
echo "Processing $domain..."
    # Export the domain's defaults to a temporary file
    defaults export "$domain" - | plutil -convert json -o "temp_$domain.json" -
    
    # If the conversion was successful, add it to our main JSON
    if [ -s "temp_$domain.json" ]; then
        # Use jq to merge the files
        jq --arg domain "$domain" '. + {($domain): input}' all_defaults.json "temp_$domain.json" > "temp_combined.json"
        mv "temp_combined.json" all_defaults.json
    fi
    
    # Clean up temporary file
    rm -f "temp_$domain.json"
done