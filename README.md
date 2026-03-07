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

### `script-command.template.sh`

Raycast starter template script from the Script Commands docs.
- Duplicate this file and remove ".template." from the filename to get started.
- See full documentation here: https://github.com/raycast/script-commands
