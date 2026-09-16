#!/usr/bin/env sh

WORKTREE_PATH=$(echo "$HERDR_PLUGIN_EVENT_JSON" | jq -r '.data.worktree.path')
cd "$WORKTREE_PATH"

[ -f Gemfile ] && grep -q rails Gemfile || exit 0

if bundle list --name-only 2>/dev/null | grep -q '^cssbundling-rails$'; then
  bundle exec rails css:install
fi
