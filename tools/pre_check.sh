#!/usr/bin/env bash
# pre_check.sh — détection LPE john-cron ou PATH hijack générique

set -euo pipefail

# 1. Vérif john-cron
if grep -qE '(/var/lib/john|john)' /etc/crontab /etc/cron.*/* 2>/dev/null; then
  TARGET_DIR="/var/lib/john"
  if [ -d "$TARGET_DIR" ] && [ -w "$TARGET_DIR" ]; then
    echo "VULNERABLE: john-cron found at $TARGET_DIR"
    exit 0
  fi
fi

# 2. Scan PATH-hijack générique
ROOT_PATH=$(sudo -E bash -c 'echo $PATH')
IFS=':' read -r -a PATH_DIRS <<< "$ROOT_PATH"

is_writable() { [ -d "$1" ] && [ -w "$1" ]; }

check_dir() {
  local dir=$1 cmd
  for cmd in $(grep -RhoP '^\s*(?:\*|\d+|\@[^ ]+)\s+(?:\S+\s+){5}\K[^#/ ]+' \
      /etc/crontab /etc/cron.*/* 2>/dev/null); do
    if [[ ! "$cmd" =~ / ]]; then
      if is_writable "$dir"; then
        echo "VULNERABLE: PATH hijack possible via command '$cmd' in $dir"
        echo "$dir" > /tmp/.lpe_target_dir
        exit 0
      fi
    fi
  done
}

for d in "${PATH_DIRS[@]}"; do
  check_dir "$d"
done

echo "NOT VULNERABLE"
exit 1
