# Raycast Scripts

Raycast script commands

## Scripts

### `chmod +x fujifilm-download.sh`

**Raycast title:** `Copy Camera Photos`

Copies Fujifilm camera photos from either of these mounted SD card paths:

- `/Volumes/SanDisk_1/DCIM/100_FUJI`
- `/Volumes/SanDisk_2/DCIM/100_FUJI`

Photos are copied into a dated folder in Downloads:

- `$HOME/Downloads/YYYY-MM-DD`

Behavior:

- Fails with an error if neither SD card path exists.
- Creates the destination folder if needed.
- Copies from whichever card(s) are available.

### `chmod +x fujifilm-delete.sh`

**Raycast title:** `Delete Camera Photos`

Deletes all files/folders inside Fujifilm photo folders from whichever SD cards are currently mounted:

- `/Volumes/SanDisk_1/DCIM/100_FUJI`
- `/Volumes/SanDisk_2/DCIM/100_FUJI`

Behavior:

- Fails with an error if neither SD card path exists.
- Stays in Raycast (no macOS popup).
- Requires typing `DELETE` in the Raycast argument field to confirm deletion.
- Deletes only folder contents (keeps the `100_FUJI` folder itself).
- Handles one missing card and processes the inserted one.
- Shows how many image files are found and deleted per inserted card.
- Shows a final success summary with total image count deleted.

### `chmod +x fujifilm-eject.sh`

**Raycast title:** `Eject Camera SD Cards`

Ejects whichever of these SD cards are currently mounted:

- `/Volumes/SanDisk_1`
- `/Volumes/SanDisk_2`

Behavior:

- Fails with an error if neither SD card is mounted.
- Ejects one or both cards depending on what is inserted.
- Reports per-card success/failure and a final summary.

### `chmod +x fujifilm-download-delete-eject.sh`

**Raycast title:** `Download Delete Eject`

Runs the full Fujifilm workflow in this order:

1. Download photos
2. Delete photos from card(s)
3. Eject card(s)

Behavior:

- Stays in Raycast and requires typing `RUN` in the argument field.
- Calls the existing scripts in sequence.
- Stops immediately if download or delete fails.
- Reports step-by-step status and final success/failure.

### `script-command.template.sh`

Raycast starter template script from the Script Commands docs.
- Duplicate this file and remove ".template." from the filename to get started.
- See full documentation here: https://github.com/raycast/script-commands
