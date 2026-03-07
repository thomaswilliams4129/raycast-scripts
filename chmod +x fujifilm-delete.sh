#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Delete Camera Photos
# @raycast.mode fullOutput
# @raycast.icon 🗑️
# @raycast.argument1 { "type": "text", "placeholder": "Type DELETE to confirm" }

# Fujifilm card paths to scan for the active DCIM folder.
SOURCE1="/Volumes/SanDisk_1/DCIM/100_FUJI"
SOURCE2="/Volumes/SanDisk_2/DCIM/100_FUJI"

# Tracks mounted/available source folders we can safely process.
AVAILABLE=()
# Tracks expected cards that are currently not mounted.
MISSING=()

# Detect whether SanDisk_1 is available.
if [ -d "$SOURCE1" ]; then
  AVAILABLE+=("$SOURCE1")
else
  MISSING+=("SanDisk_1")
fi

# Detect whether SanDisk_2 is available.
if [ -d "$SOURCE2" ]; then
  AVAILABLE+=("$SOURCE2")
else
  MISSING+=("SanDisk_2")
fi

# If no cards are mounted, stop before doing anything destructive.
if [ ${#AVAILABLE[@]} -eq 0 ]; then
  echo "❌ No SanDisk drives found"
  echo "Expected one of:"
  echo "- $SOURCE1"
  echo "- $SOURCE2"
  exit 1
fi

# Build the list of mounted card names for confirmation/status output.
TARGET_LINES=""
for path in "${AVAILABLE[@]}"; do
  TARGET_LINES+="- $(basename "$(dirname "$(dirname "$path")")")\n"
done

# Require an explicit in-Raycast confirmation value before deleting.
CONFIRM_INPUT="${1:-}"
if [ "$CONFIRM_INPUT" != "DELETE" ]; then
  echo "⚠️ Deletion not started."
  echo "Mounted cards:"
  printf "%b" "$TARGET_LINES"
  echo ""
  echo "Type DELETE in the Raycast argument field to confirm."
  exit 0
fi

# Process each mounted card independently.
TOTAL_IMAGES=0
TOTAL_DELETED=0

for path in "${AVAILABLE[@]}"; do
  # Resolve display name like "SanDisk_1" from the folder path.
  card_name="$(basename "$(dirname "$(dirname "$path")")")"
  # Count image files recursively before deletion.
  image_count=$(find "$path" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.raf" -o -iname "*.png" -o -iname "*.tif" -o -iname "*.tiff" -o -iname "*.heic" \) | wc -l | tr -d ' ')
  # Count top-level items to decide whether folder is already empty.
  count=$(find "$path" -mindepth 1 -maxdepth 1 | wc -l | tr -d ' ')
  TOTAL_IMAGES=$((TOTAL_IMAGES + image_count))

  # Skip deletion if the folder is already empty.
  if [ "$count" -eq 0 ]; then
    echo "ℹ️ $card_name is already empty"
    continue
  fi

  echo "📸 Found $image_count image(s) on $card_name"
  echo "🗑️ Deleting $image_count image(s) from $card_name..."

  # Delete only folder contents, keeping the 100_FUJI directory itself.
  find "$path" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  TOTAL_DELETED=$((TOTAL_DELETED + image_count))
  echo "✅ Deleted $image_count image(s) from $card_name"
done

# Final in-view success alert line for Raycast output.
echo "✅ Success: Deleted $TOTAL_DELETED image(s) (found $TOTAL_IMAGES total)."
