defmodule ParallelDownload.MixProject do
  use Mix.Project

  def project do
    [
      app: :parallel_download,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ParallelDownload.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~>1.3.3"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
