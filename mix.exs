defmodule FirebaseAdminEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :firebase_admin_ex,
      version: "0.2.0",
      elixir: "~> 1.6",
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
      {:goth, "~> 1.1.0"},
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},

      # Telsa  deps
      {:castore, "~> 0.1.0"},
      {:mint, "~> 1.0"}
    ]
  end

  defp description() do
    "The Firebase Admin Elixir SDK"
  end
end
