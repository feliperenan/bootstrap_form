defmodule BootstrapForm.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :bootstrap_form,
      version: @version,
      elixir: "~> 1.7",
      deps: deps(),
      name: "BootstrapForm",
      description: "A easier way to build Boostrap forms using Phoenix.HTML.Form.",
      package: package(),
      docs: [
        source_ref: "v#{@version}",
        main: "BootstrapForm",
        source_url: "https://github.com/feliperenan/bootstrap_form"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_html, ">= 2.13.1"},
      {:ex_doc, "~> 0.18", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Felipe Renan"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/feliperenan/bootstrap_form"},
      files: ~w(lib mix.exs README.md)
    ]
  end
end
