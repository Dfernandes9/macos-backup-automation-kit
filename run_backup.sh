#!/bin/bash
set -euo pipefail
  

# Configuration file path (default to config.json in repo)
CONFIG_FILE="${1:-config.json}"

# Determine script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run Time Machine backup
bash "$SCRIPT_DIR/time_machine_backup.sh" "$CONFIG_FILE"

# Run iCloud Drive consolidation
bash "$SCRIPT_DIR/icloud_consolidate.sh" "$CONFIG_FILE"

# Run iMazing backups
bash "$SCRIPT_DIR/imazing_backup.sh" "$CONFIG_FILE"

# Verify backups after completion
bash "$SCRIPT_DIR/verify_backup.sh" "$CONFIG_FILE"

echo "All backup tasks completed."
