defmodule Blog.Mixfile do
  use Mix.Project

  def project do
    [app: :blog,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Blog, []},
     applications: [
       :phoenix, :phoenix_ecto, :cowboy, :comeonin, :logger, :ecto, :earmark, :timex,
       :postgrex, :xml_builder, :phoenix_html
     ]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.14"},
     {:phoenix_ecto, "~> 0.4"},
     {:phoenix_html, "~> 1.2.1"},
     {:earmark, "~> 0.1.8"},
     {:exrm, "~> 0.19.9"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_live_reload, "~> 0.4.3"},
     {:comeonin, "~> 0.8"},
     {:cowboy, "~> 1.0"},
     {:timex, "~> 0.19.2"},
     {:xml_builder, "~> 0.0.5"}
   ]

  end
end
