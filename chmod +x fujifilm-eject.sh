#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Eject SD Cards
# @raycast.mode silent
# @raycast.icon 💾

# Expected mounted volume roots for the camera SD cards.
VOLUME1="/Volumes/SanDisk_1"
VOLUME2="/Volumes/SanDisk_2"

MOUNTED=()

# Track which cards are currently inserted/mounted.
if [ -d "$VOLUME1" ]; then
  MOUNTED+=("$VOLUME1")
fi

if [ -d "$VOLUME2" ]; then
  MOUNTED+=("$VOLUME2")
fi

# Nothing to eject if neither card is mounted.
if [ ${#MOUNTED[@]} -eq 0 ]; then
  echo "❌ No SanDisk cards are mounted"
  echo "Expected one of:"
  echo "- $VOLUME1"
  echo "- $VOLUME2"
  exit 1
fi

SUCCESS=0
FAILED=0

# Eject each mounted card independently.
for volume in "${MOUNTED[@]}"; do
  card_name="$(basename "$volume")"
  echo "⏏️ Ejecting $card_name..."

  if diskutil eject "$volume" >/dev/null 2>&1; then
    SUCCESS=$((SUCCESS + 1))
    echo "✅ Ejected $card_name"
  else
    FAILED=$((FAILED + 1))
    echo "❌ Failed to eject $card_name"
  fi
done

# Final summary for Raycast output.
echo ""
echo "Done: $SUCCESS ejected, $FAILED failed."

if [ "$FAILED" -gt 0 ]; then
  exit 1
fi
