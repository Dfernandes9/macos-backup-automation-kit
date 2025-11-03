verify_backup.sh#!/bin/bash
set -euo pipefail

# Verify backup integrity for Time Machine, iCloud Drive, and iMazing.
# Reads config file (config.json or path specified as first argument) for directories to verify.

CONFIG_FILE="${1:-config.json}"

# Check latest Time Machine backup
if tmutil latestbackup >/dev/null 2>&1; then
  LATEST_TM=$(tmutil latestbackup)
  echo "Latest Time Machine backup: $LATEST_TM"
else
  echo "No Time Machine backup found or tmutil command failed."
fi

ICLOUD_DIR=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(cfg.get('icloud_backup_dest',''))")
IMAZING_DIR=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(cfg.get('imazing_backup_dir',''))")

# Verify iCloud backup directory
if [ -n "$ICLOUD_DIR" ] && [ -d "$ICLOUD_DIR" ]; then
  if [ "$(ls -A "$ICLOUD_DIR")" ]; then
    echo "iCloud backup directory ($ICLOUD_DIR) exists and is not empty."
  else
    echo "Warning: iCloud backup directory ($ICLOUD_DIR) is empty."
  fi
else
  echo "iCloud backup directory ($ICLOUD_DIR) does not exist."
fi

# Verify iMazing backup directory
if [ -n "$IMAZING_DIR" ] && [ -d "$IMAZING_DIR" ]; then
  if [ "$(ls -A "$IMAZING_DIR")" ]; then
    echo "iMazing backup directory ($IMAZING_DIR) exists and is not empty."
  else
    echo "Warning: iMazing backup directory ($IMAZING_DIR) is empty."
  fi
else
  echo "iMazing backup directory ($IMAZING_DIR) does not exist."
fi

echo "Backup verification completed."
