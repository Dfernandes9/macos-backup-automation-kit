#!/bin/bash
set -euo pipefail

# Consolidate iCloud Drive data to a local backup destination using rsync.
# Reads config from config.json (or path specified as first argument) with key "icloud_backup_dest" and optional "icloud_source_dir".
# The default iCloud Drive source is ~/Library/Mobile Documents/com~apple~CloudDocs.

CONFIG_FILE="${1:-config.json}"

DEST_DIR=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(cfg.get('icloud_backup_dest',''))")
SOURCE_DIR=$(python3 -c "import json, sys; cfg=json.load(open('$CONFIG_FILE')); print(cfg.get('icloud_source_dir',''))")

if [ -z "$SOURCE_DIR" ]; then
  SOURCE_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
fi

if [ -z "$DEST_DIR" ]; then
  echo "iCloud backup destination not specified in config."
  exit 1
fi

mkdir -p "$DEST_DIR"

RSYNC_OPTS="--verbose --recursive --delete-before --whole-file --times"

if [ "${DRY_RUN:-}" = "1" ]; then
  RSYNC_OPTS="$RSYNC_OPTS --dry-run"
  echo "Running in dry-run mode. No files will be copied."
fi

rsync $RSYNC_OPTS "${SOURCE_DIR}/" "${DEST_DIR}/"

echo "iCloud Drive consolidation complete."
