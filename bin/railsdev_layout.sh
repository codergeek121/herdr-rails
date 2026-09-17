#!/usr/bin/env sh
set -eu

workspace_id="${HERDR_ACTIVE_WORKSPACE_ID:-${HERDR_WORKSPACE_ID:-}}"
current_tab_id="${HERDR_ACTIVE_TAB_ID:-${HERDR_TAB_ID:-}}"
current_pane_id="${HERDR_ACTIVE_PANE_ID:-${HERDR_PANE_ID:-}}"

make_tab() {
  tab_output=$(herdr tab create --workspace "$workspace_id" --label "$1")
  echo "$(printf '%s' "$tab_output" | jq -r '.result.root_pane.pane_id') $(printf '%s' "$tab_output" | jq -r '.result.tab.tab_id')"
}

herdr tab rename "$current_tab_id" "Editor"
herdr pane run "$current_pane_id" "${EDITOR:-${VISUAL:-vi}}"

read -r rails_left_pane rails_tab_id <<EOF
$(make_tab "Rails")
EOF
herdr pane run "$rails_left_pane" "bin/rails s"

rails_right_pane=$(herdr pane split "$rails_left_pane" --direction right | jq -r '.result.pane.pane_id')
herdr pane run "$rails_right_pane" "bin/rails console"

make_tab "Terminal" > /dev/null

herdr tab focus "$current_tab_id"
