defmodule NioGoogleGeocoder.Changeset do
  @moduledoc """
  This module allows a google authenticator secret
  to be inserted into an Ecto.changeset.
  """

  import NioGoogleGeocoder, only: [geocode: 1]
  import Ecto.Changeset, only: [get_field: 2, put_change: 3]

  @doc """
  """
  def add_geo_coordinates_to_changeset(changeset, address_fields, latitude_field, longitude_field) do
    if address_fields |> Enum.any?(fn field -> Map.has_key?(changeset.changes, field) end) do
      merged_fields = Map.merge(changeset.model, changeset.changes)

      new_address =
        address_fields
          |> Enum.map(fn field -> Map.get(merged_fields, field) end)
          |> Enum.join(" ")

      case geocode(new_address) do
        {:ok, [%{"geometry"=>%{"location"=>%{"lat"=>lat,"lng"=>lng}}}]}
          -> changeset
              |> put_change(latitude_field, lat)
              |> put_change(longitude_field, lng)
        _ -> changeset
      end
    else
      changeset
    end
  end
end
