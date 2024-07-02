#!/bin/zsh

# Author: Chance
# Date: 2024-07-01
# Description: This script looks in the directory provided and runs Tyler's tide model for every 
#   available granule, then outputs them into a subdirectory named 'tides'

# Check if a directory argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Set the directory variable to the first argument
directory=$1

# Check if the provided argument is a valid directory
if [ ! -d "$directory" ]; then
  echo "Error: $directory is not a valid directory."
  exit 1
fi

# Check if a tides directory exists
if [ ! -d "${directory}/tides" ]; then
  echo " No directory <tides>, creating.."
  mkdir ${1}/tides
  exit 1
fi

# Function definitions
# Define any functions here
#process_directory() {
#  local dir=$1
#  echo "Processing directory: $dir"
  # Add your directory processing logic here
#}

# Main script execution
# Call your function with the directory argument
#process_directory "$directory"

# End of script