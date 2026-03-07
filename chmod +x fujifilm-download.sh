#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Copy Camera Photos
# @raycast.mode silent
# @raycast.icon 📷

SOURCE1="/Volumes/SanDisk_1/DCIM/100_FUJI"
SOURCE2="/Volumes/SanDisk_2/DCIM/100_FUJI"
DEST="$HOME/Downloads/$(date +%Y-%m-%d)"

# Check if at least one drive is available
if [ ! -d "$SOURCE1" ] && [ ! -d "$SOURCE2" ]; then
  echo "❌ No SanDisk drives found"
  exit 1
fi

mkdir -p "$DEST"

# Copy from SanDisk_1 if available
if [ -d "$SOURCE1" ]; then
  echo "📷 Copying from SanDisk_1..."
  cp -r "$SOURCE1"/* "$DEST/" 2>/dev/null
  echo "✅ Copied from SanDisk_1"
fi

# Copy from SanDisk_2 if available
if [ -d "$SOURCE2" ]; then
  echo "📷 Copying from SanDisk_2..."
  cp -r "$SOURCE2"/* "$DEST/" 2>/dev/null
  echo "✅ Copied from SanDisk_2"
fi

echo "✅ All photos copied to $DEST"
