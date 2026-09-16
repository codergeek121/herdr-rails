#!/usr/bin/env sh

set -eu

WORKTREE_PATH=$(echo "$HERDR_PLUGIN_EVENT_JSON" | jq -r '.data.worktree.path')
cd "$WORKTREE_PATH"

[ -f Gemfile ] && grep -q rails Gemfile || exit 0

bundle exec rails db:prepare
