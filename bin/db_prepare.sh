#!/usr/bin/env sh

set -eu

. "$(dirname "$0")/../lib/common.sh"

cd_to_worktree
is_rails || exit 0

bundle exec rails db:prepare
