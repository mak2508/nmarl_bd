#!/bin/bash -l 

# Check if modules.txt exists
if [ ! -f "modules.txt" ]; then
    echo "Error: modules.txt not found."
    exit 1
fi

# Read modules from modules.txt and load each module
while IFS= read -r module; do
    module load "$module"
    if [ $? -ne 0 ]; then
        echo "Error loading module: $module"
        exit 1
    fi
done < modules.txt

echo "All modules loaded successfully."
