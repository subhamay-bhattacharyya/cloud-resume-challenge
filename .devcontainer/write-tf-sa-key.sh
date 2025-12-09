#!/usr/bin/env bash
set -euo pipefail

# Write TERRAFORM_SA_KEY into the repository relative path tf/tf-sa-key/terraform-sa-key.json
# The script assumes it's run from the repository root (devcontainer postStartCommand does this).

LOG="/tmp/devcontainer-poststart.log"
TARGET_DIR="$(pwd)/infra/gcp/tf/tf-sa-key"
TARGET_FILE="$TARGET_DIR/terraform-sa-key.json"

echo "$(date -Is) - write-tf-sa-key.sh starting" >> "$LOG"
mkdir -p "$TARGET_DIR"

if [ -n "${TERRAFORM_SA_KEY:-}" ]; then
  printf '%s' "$TERRAFORM_SA_KEY" > "$TARGET_FILE"
  chmod 600 "$TARGET_FILE"
  echo "$(date -Is) - Wrote $TARGET_FILE (permissions 600)" >> "$LOG"
else
  echo "$(date -Is) - TERRAFORM_SA_KEY not set; skipping creation of $TARGET_FILE" >> "$LOG"
fi

echo "$(date -Is) - write-tf-sa-key.sh finished" >> "$LOG"

exit 0