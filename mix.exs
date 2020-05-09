defmodule LetterLinesElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :letter_lines_elixir,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:credo, "~> 1.3.0"},
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
end
