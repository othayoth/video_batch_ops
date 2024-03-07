#!/bin/bash

# Video file to process
VIDEO_FILE="/path/to/your/video.mp4"

# Extract every Nth frame
N=10

# Output directory for extracted frames
OUTPUT_DIR="/path/to/extracted/frames"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# FFmpeg command to extract every Nth frame
ffmpeg -i "$VIDEO_FILE" -vf "select=not(mod(n\,$N))" -vsync vfr "$OUTPUT_DIR/frame_%06d.png"

echo "Extraction completed."
