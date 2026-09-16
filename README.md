# Herdr-Rails Plugin

Simplifies worktree based agentic Rails development with Herdr.

## Features:

* Runs `rails db:prepare` for new worktrees
* Runs `rails css:install` for new worktrees if cssbundling-rails is present
* Runs `rails javascript:install` for new worktrees if jsbundling-rails is present

## Separate databases per worktree

By default all worktrees share the same database. If you want each worktree to
use its own database (so parallel agents don't step on each other's data), you
don't need any changes to this plugin — Herdr already exposes a per-worktree
identity via the `HERDR_WORKSPACE_ID` environment variable, which is available
throughout the worktree.

Opt in from your app by referencing that variable in `config/database.yml`
(it's evaluated as ERB):

```yaml
development:
  <<: *default
  database: myapp_development<%= "_#{ENV['HERDR_WORKSPACE_ID']}" if ENV['HERDR_WORKSPACE_ID'] %>

test:
  <<: *default
  database: myapp_test<%= "_#{ENV['HERDR_WORKSPACE_ID']}" if ENV['HERDR_WORKSPACE_ID'] %>
```

* Outside of Herdr (local machine, CI) the variable is unset, so your regular
  database names are used and nothing changes.
* Inside a worktree the name becomes e.g. `myapp_development_<id>`, giving each
  worktree its own database.
* The existing `rails db:prepare` step creates the namespaced database
  automatically — it just reads `database.yml`, so no extra setup is required.

## TODOs

* TODO: Handle multiple test DBs without app configuration change
* TODO: Failure should mark the pane as "blocked"
* TODO: Copy Bootsnap Cache for worktrees
