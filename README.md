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

### `script-command.template.sh`

Raycast starter template script from the Script Commands docs.

What it does:

- Provides required Raycast metadata fields.
- Includes optional metadata examples.
- Prints `Hello from My First Script` as a starter output.

Use this as a base when creating new script commands.
