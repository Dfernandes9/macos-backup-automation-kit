#!/bin/bash
# time_machine_backup.sh
#
# This script enables Time Machine, sets the destination, applies exclusions, and triggers a backup.
# It expects a JSON configuration file as its first argument or uses a local config.json.
#
# Requirements:
# - macOS with Time Machine
# - Python 3 (for parsing JSON)
#
# Example usage:
#   ./time_machine_backup.sh config.json

set -euo pipefail

CONFIG_FILE="${1:-$(dirname "$0")/config.json}"

# Function to extract values from the JSON config using Python.
get_json_value() {
    python3 - "$CONFIG_FILE" "$1" <<'PY'
import json, sys, pathlib
cfg = json.load(open(sys.argv[1]))
key = sys.argv[2]
print(cfg.get(key, ""))
PY
}

DESTINATION="$(get_json_value time_machine_destination)"
EXCLUDES="$(get_json_value time_machine_exclude_paths)"

# Enable Time Machine backups
sudo tmutil enable || true

# Set the backup destination if provided
if [[ -n "$DESTINATION" ]]; then
    # Remove any existing destination and set the new one
    current_dest=$(tmutil destinationinfo 2>/dev/null | awk -F': ' '/ID/{print $2}')
    if [[ -n "$current_dest" ]]; then
        sudo tmutil removedestination "$current_dest" || true
    fi
    sudo tmutil setdestination "$DESTINATION"
fi

# Apply exclusion paths if provided (comma-separated)
if [[ -n "$EXCLUDES" ]]; then
    IFS=',' read -ra EXCLUDE_LIST <<< "$EXCLUDES"
    for p in "${EXCLUDE_LIST[@]}"; do
        sudo tmutil addexclusion "$p"
    done
fi

# Trigger the backup using --auto so that it behaves like an automatic backup.
echo "Starting Time Machine backup…"
tmutil startbackup --auto
