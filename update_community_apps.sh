#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_FILE="$ROOT_DIR/plugins/community.applications.plg"
PATCH_FILE="$ROOT_DIR/plugins/set_proxy.patch"
REMOTE_URL="https://raw.githubusercontent.com/unraid/community.applications/refs/heads/master/plugins/community.applications.plg"

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

curl -fsSL "$REMOTE_URL" -o "$TMP_FILE"
mv "$TMP_FILE" "$PLUGIN_FILE"

git -C "$ROOT_DIR" apply --directory=plugins -- "$PATCH_FILE"
