#!/bin/zsh

# SVG to PNG Converter Script
# Converts all SVG files in the current directory to PNG using ImageMagick 7

# Check if ImageMagick 7 is installed
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick 7 is not installed."
    echo "Please install it using: brew install imagemagick"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p png_output

# Count SVGs
svg_count=$(ls -1 *.svg 2>/dev/null | wc -l)
if [ $svg_count -eq 0 ]; then
    echo "No SVG files found in the current directory."
    exit 0
fi

echo "Found $svg_count SVG files. Starting conversion..."

# Convert all SVGs to PNGs
for svg_file in *.svg; do
    # Get filename without extension
    filename=$(basename -- "$svg_file" .svg)
    
    # Convert SVG to PNG
    echo "Converting $svg_file to ${filename}.png"
    magick convert "$svg_file" "png_output/${filename}.png"
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "  ✓ Successfully converted $svg_file"
    else
        echo "  ✗ Failed to convert $svg_file"
    fi
done

echo "Conversion complete. PNG files are in the 'png_output' directory."
