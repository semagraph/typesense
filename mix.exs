defmodule Typesense.MixProject do
  use Mix.Project

  def project do
    [
      app: :typesense,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: "TypeSense API library for Elixir",
      package: package(),
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:tesla, "~> 1.4.0"},
      {:hackney, "~> 1.16.0"},
      {:jason, ">= 1.0.0"},
    ]
  end

  def package do
    [
      files: ["lib", "LICENSE.md", "mix.exs", "README.md", "CHANGELOG.md"],
      maintainers: ["semagraph"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/semagraph/typesense"}
    ]
  end
end
