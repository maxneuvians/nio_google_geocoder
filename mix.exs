defmodule NioGoogleGeocoder.Mixfile do
  use Mix.Project

  def project do
    [app: :nio_google_geocoder,
     version: "0.7.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ecto, "~> 1.1"},
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"}
    ]
  end

  defp description do
    """
    NioGoogleGeocoder is a collection of Elixir convenience functions to
    geocode a single, or list of, addresses. It also includes a function
    that automatically adds a geo location to an `Ecto.Changeset`.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Max Neuvians"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/maxneuvians/nio_google_geocoder",
              "Docs" => "https://github.com/maxneuvians/nio_google_geocoder"}]
  end

end
