#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Download Delete Eject
# @raycast.mode fullOutput
# @raycast.icon 🔁
# @raycast.argument1 { "type": "text", "placeholder": "Type RUN to start" }

# Run all three camera tasks in order from this script's directory.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOWNLOAD_SCRIPT="$SCRIPT_DIR/chmod +x fujifilm-download.sh"
DELETE_SCRIPT="$SCRIPT_DIR/chmod +x fujifilm-delete.sh"
EJECT_SCRIPT="$SCRIPT_DIR/chmod +x fujifilm-eject.sh"

# Require explicit in-Raycast confirmation before any action.
if [ "${1:-}" != "RUN" ]; then
  echo "⚠️ Workflow not started."
  echo "Type RUN in the Raycast argument field to execute:"
  echo "1) Download photos"
  echo "2) Delete photos"
  echo "3) Eject cards"
  exit 0
fi

# Ensure required scripts exist before running the workflow.
if [ ! -f "$DOWNLOAD_SCRIPT" ] || [ ! -f "$DELETE_SCRIPT" ] || [ ! -f "$EJECT_SCRIPT" ]; then
  echo "❌ One or more required scripts are missing."
  exit 1
fi

echo "▶️ Step 1/3: Download photos"
if ! bash "$DOWNLOAD_SCRIPT"; then
  echo "❌ Workflow stopped: download failed."
  exit 1
fi

echo ""
echo "▶️ Step 2/3: Delete photos"
if ! bash "$DELETE_SCRIPT" DELETE; then
  echo "❌ Workflow stopped: delete failed."
  exit 1
fi

echo ""
echo "▶️ Step 3/3: Eject cards"
if ! bash "$EJECT_SCRIPT"; then
  echo "❌ Workflow finished with errors during eject."
  exit 1
fi

echo ""
echo "✅ Workflow complete: download, delete, and eject finished."
