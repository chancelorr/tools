#!/bin/bash

# Define the directory path
directory="../rifts/shapes/ross/"

# Character position to replace (0-based index)
position=4

# Character to replace
old_char=""

# New character
new_char="_r1"

# Navigate to the directory
cd "$directory" || exit

# Iterate over all files in the directory
for file in *; do
    # Check if the file exists and is a regular file
    if [[ -f "$file" ]]; then
        # Get the filename without the directory path
        filename=$(basename "$file")
        
        # Replace the character at the specified position
        new_filename="${filename:0:$position}${filename:$((position + 1))}"
        new_filename="${new_filename:0:$position}$new_char${new_filename:$((position))}"

        # Rename the file
        mv "$file" "${new_filename}"
        
        echo "Renamed '$file' to '${new_filename}'"
    fi
done
