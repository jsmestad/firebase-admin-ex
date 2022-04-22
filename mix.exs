defmodule FirebaseAdminEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :firebase_admin_ex,
      version: "0.2.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description()
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
      {:tesla, "~> 1.4"},
      {:jason, "~> 1.0"},
      {:goth, ">= 1.3.0-rc.3"},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:hackney, "~> 1.17"},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end

  defp description do
    "The Firebase Admin Elixir SDK"
  end
end
