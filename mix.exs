defmodule LetterLinesElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :letter_lines_elixir,
      version: "0.1.0",
      elixir: "~> 1.10.2",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs",
        list_unused_filters: true
      ],
      preferred_cli_env: [
        credo: :test,
        coveralls: :test,
        "coveralls.html": :test,
        coverage_report: :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Static analysis and linting
      {:credo, "~> 1.4.0", only: :test, runtime: false},
      # Static analysis
      {:dialyxir, "~> 1.0.0-rc.7", only: :dev, runtime: false},
      # Test coverage
      {:excoveralls, "~> 0.12.3", only: :test},
      # Run checks before commit and push
      {:git_hooks, "~> 0.4.1", only: :dev, runtime: false},
      # Continuous test running
      {:mix_test_watch, "~> 1.0.2", only: :dev, runtime: false},
      # Mocking for tests
      {:mox, "~> 0.5", only: :test}
    ]
  end

  defp aliases do
    [
      compile: "compile --warnings-as-errors",
      coverage_report: [&coverage_report/1],
      "git.check": ["git_hooks.run all"],
      "hex.version_check": "run --no-start hex_version_check.exs"
    ]
  end

  defp coverage_report(_) do
    Mix.Task.run("coveralls.html")

    open_cmd =
      case :os.type() do
        {:win32, _} ->
          "start"

        {:unix, :darwin} ->
          "open"

        {:unix, _} ->
          "xdg-open"
      end

    System.cmd(open_cmd, ["cover/excoveralls.html"])
  end
end
