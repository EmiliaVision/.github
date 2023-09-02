#!/bin/bash

# Create the 'transparent' directory only if it doesn't exist
[ ! -d "transparent" ] && mkdir -p transparent

# Loop through each .png file in the 'black' directory
for file in black/*.png; do
  # Extract the filename without the path or extension
  filename=$(basename -- "$file")
  filename_noext="${filename%.*}"

  # Check if file already exists in 'transparent' directory
  if [ -f "transparent/${filename_noext}.png" ]; then
    echo "File transparent/${filename_noext}.png already exists. Skipping..."
    continue
  fi

  # Convert black to transparent and save as .png
  convert "$file" -alpha set -channel RGBA -fx 'a = intensity; r = r/a; g = g/a; b = b/a' "transparent/${filename_noext}.png"

  # Convert the newly created .png to .webp
  convert "transparent/${filename_noext}.png" "transparent/${filename_noext}.webp"
done

