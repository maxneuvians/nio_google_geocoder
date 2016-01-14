# NioGoogleGeocoder

NioGoogleGeocoder is a collection of Elixir convenience functions to geocode as single or list of addresses.

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

## ToDO

Allow for the additional params specified here:
https://developers.google.com/maps/documentation/geocoding/intro

### Version
0.5.0

License
----
MIT
