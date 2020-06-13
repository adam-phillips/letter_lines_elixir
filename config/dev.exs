import Config

# Define git hooks to run in dev before commits or pushes. Task failures prevent git action taken until fixes applied
config :git_hooks,
  hooks: [
    pre_commit: [
      verbose: true,
      tasks: [
        # Check that file is already formatted, formatting will not change the AST, and format without saving files
        # Settings use default .formatter.exs; any `--check-*` failure prevents saving changes or printing to STDIO
        "mix format --check-formatted --dry-run --check-equivalent"
      ]
    ],
    pre_push: [
      verbose: true,
      tasks: [
        "mix clean",
        "mix compile --warnings-as-errors",
        "mix hex.version_check",
        "mix credo --strict",
        "mix dialyzer --halt-exit-status"
      ]
    ]
  ]
