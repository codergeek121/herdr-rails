# Herdr-Rails Plugin

Simplifies worktree based agentic Rails development with Herdr.

## Features:

* Runs `rails db:prepare` for new worktrees
* Runs `rails css:install` for new worktrees if cssbundling-rails is present
* Runs `rails javascript:install` for new worktrees if jsbundling-rails is present

## TODOs

* TODO: Handle multiple test DBs without app configuration change
* TODO: Failure should mark the pane as "blocked"
