# NioGoogleGeocoder

NioGoogleGeocoder is a collection of Elixir convenience functions to geocode a single, or list of, addresses. It also includes a function that automatically adds a geo location to an `Ecto.Changeset`.

## Installation
Add `nio_google_geocoder` to your list of dependencies in `mix.exs`:
```
def deps do
[{:nio_google_geocoder, "~> 0.5.0"}]
end
```

## Usage

##### Geocoding an address:

`.geocode("74 High Street, New Haven, CT, 06520")`

will return the following:

`{:ok, [%{"address_components" => ..}]}`

You can also pass it a list of addresses and the result will be a list of tuples:

`[{:ok, [%{"address_components" => ..}]}, {:ok, [%{"address_components" => ..}]} ]`

To use a specific API key set it in config:

`config :nio_google_geocoder, api_key: "API_KEY"`

In case of errors a tuple starting with `{:error, error_message}` is returned

## Ecto.Changeset usage
There is an additional function which you can pass an `Ecto.Changeset` which will automatically add latitude and longitude based on a list of address fields. It will only geocode if the address attributes are present in the `changes` map of the changeset.

##### Geocoding an address in a changeset

To geocode an address in the changeset you need to pass it `(changeset, [list of address fields], latitude_field, longitude_field)`

ex. `add_geo_coordinates_to_changeset(changeset, [:address, :city, :zip], :latitude, :longitude)`

It is important to remember that it will only update the geolocation if any of the `[list of address fields]` change. Otherwise it returns the changeset.

Also pass the list of address fields in logical order ex. `[:address, :city, :zip]` vs. `[:zip, :address, :city]` as the values of the field are concatenated for geocoding.

##### Example in Model
```
defmodule Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :name, :string
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :latitude, :float
    field :longitude, :float
  end

  def changeset(user, params \\ :empty) do
    user
    |> cast(params, ~w(name), ~w(address city state zip latitude longitude))
    |> NioGoogleGeocoder.Changeset.add_geo_coordinates_to_changeset([:address, :city, :zip], :latitude, :longitude)
  end
end
 ```

## ToDO

Allow for the additional params specified here:
https://developers.google.com/maps/documentation/geocoding/intro

### Version
0.6.0

License
----
MIT
