#!/usr/bin/env sh

set -eu

is_rails() {
  [ -f "Gemfile" ] && grep -q 'rails' Gemfile
}

cd_to_worktree() {
  worktree_path=$(echo "$HERDR_PLUGIN_EVENT_JSON" | jq -r '.data.worktree.path')
  cd "$worktree_path"
}

has_gem() {
  gem_name="$1"
  bundle list --name-only 2>/dev/null | grep -q "^${gem_name}\$"
}
