defmodule PhoenixBootstrapForm.Mixfile do
  use Mix.Project

  @project_url "https://github.com/GBH/phoenix_bootstrap_form"

  def project do
    [
      app:              :phoenix_bootstrap_form,
      version:          "0.1.0",
      elixir:           "~> 1.4",
      source_url:       @project_url,
      homepage_url:     @project_url,
      name:             "Phoenix Bootstrap Form",
      description:      "Bootstrap 4 Forms for Phoenix Applications",
      build_embedded:   Mix.env == :prod,
      start_permanent:  Mix.env == :prod,
      package:          package(),
      deps:             deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:phoenix_html, "~> 2.7"},
      {:phoenix,      "~> 1.2"},
      {:ex_doc,       ">= 0.0.0", only: :dev}
    ]
  end

   defp package do
    [
      maintainers:  ["Oleg Khabarov"],
      licenses:     ["MIT"],
      links:        %{"GitHub" => @project_url}
    ]
  end
end
