defmodule NioGoogleGeocoder do
  @moduledoc """
  This module provides simple wrapper functions to request geocode information
  from Google based on a single or list of addresses.
  """

  @api_key Application.get_env(:nio_google_geocoder, :api_key) || nil
  @url_endpoint "https://maps.googleapis.com/maps/api/geocode/json?"

  @doc """
  Returns a tuple or list of tuples of geocoding results
  """
  def geocode(address) when is_binary(address) do
    address
      |> build_query(@api_key)
      |> URI.encode
      |> build_url
      |> get
  end
  def geocode([]), do: []
  def geocode([h|t]), do: [geocode(h) | geocode(t)]
  def geocode(_), do: {:error, "Geocode requires a string or list of strings."}

  # Joins the query params
  defp build_query(address, nil), do: "address=" <> address
  defp build_query(address, key), do: "address=" <> address <> "&key=" <> key

  # Joins encoded query params to the base url
  defp build_url(query), do: @url_endpoint <> query

  # Executes the geocoding request and returns a tuple starting with :ok or :error
  defp get(url) do
    HTTPoison.start
    case HTTPoison.get(url, [], []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}}
        ->
          case body |> Poison.decode! do
            %{"results" => results, "status" => _}
              -> {:ok, results}
            %{"error_message" => message, "results" => _, "status" => status}
              -> {:error, status <> ": " <> message}
        end
      {:error, %HTTPoison.Error{id: _, reason: error}}
        -> {:error, error}
    end
  end
end
