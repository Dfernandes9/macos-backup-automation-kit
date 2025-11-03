imazing_backup.sh#!/bin/bash
set -euo pipefail

# Perform backups of connected iOS devices using iMazing CLI.
# Reads config from config.json (or path specified as first argument) with key "imazing_backup_dir" and optional "device_udids".
# iMazing CLI must be installed and accessible via the 'imazing' command.
# If device_udids list is provided, each device is backed up separately; otherwise all connected devices are backed up.

CONFIG_FILE="${1:-config.json}"

IMAZING_BACKUP_DIR=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(cfg.get('imazing_backup_dir',''))")
DEVICE_UDIDS=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(' '.join(cfg.get('device_udids', [])))")

if [ -z "$IMAZING_BACKUP_DIR" ]; then
  echo "iMazing backup directory not specified in config."
  exit 1
fi

mkdir -p "$IMAZING_BACKUP_DIR"

# Check if imazing CLI is installed
if ! command -v imazing >/dev/null 2>&1; then
  echo "iMazing CLI is not installed or not in PATH. Please install iMazing and ensure the CLI is available."
  exit 1
fi

# Perform backups
if [ -n "$DEVICE_UDIDS" ]; then
  for UDID in $DEVICE_UDIDS; do
    echo "Backing up device $UDID..."
    imazing backup --udid "$UDID" --backup-directory "$IMAZING_BACKUP_DIR" --skip-apps --skip-photos || echo "Backup for device $UDID failed."
  done
else
  echo "Backing up all connected devices..."
  imazing backup --all-devices --backup-directory "$IMAZING_BACKUP_DIR" --skip-apps --skip-photos || echo "Backup command failed."
fi

echo "iMazing backup process completed."
