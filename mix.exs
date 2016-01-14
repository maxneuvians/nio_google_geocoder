defmodule NioGoogleGeocoder.Mixfile do
  use Mix.Project

  def project do
    [app: :nio_google_geocoder,
     version: "0.5.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end
  defp deps do
    [
      {:ecto, "~> 1.1"},
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"}
    ]
  end
end
