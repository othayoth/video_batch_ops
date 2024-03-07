#!/bin/bash

# Directory containing the videos to be compressed
VIDEO_DIR="/path/to/your/videos"

# Compression quality (CRF value)
# Lower values mean better quality. Typical values range from 18 to 28.
# 23 is the default value for x264 and x265.
CRF=23

# Iterate over all mp4 files in the specified directory
for FILE in "$VIDEO_DIR"/*.mp4; do
  # Generate the output filename by appending "_compressed" before the file extension
  OUTPUT_FILE="${FILE%.mp4}_compressed.mp4"
  
  # FFmpeg command to compress video, remove audio, and set quality
  ffmpeg -i "$FILE" -c:v libx264 -preset slow -crf "$CRF" -an "$OUTPUT_FILE"
  
  echo "Processed: $OUTPUT_FILE"
done

echo "Compression completed."
