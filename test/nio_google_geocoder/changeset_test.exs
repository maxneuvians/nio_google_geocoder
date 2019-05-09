defmodule NioGoogleGeocoder.ChangesetTest do
  use ExUnit.Case
  import NioGoogleGeocoder.Changeset

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
      |> cast(params, ~w(name address city state zip latitude longitude)a)
    end
  end

  test "add_geo_coordinates_to_changeset adds latitude and longitude to a changeset" do
    changeset = Location.changeset(%Location{}, %{address: "74 High Street", city: "New Haven", zip: "06520"})
    changeset = add_geo_coordinates_to_changeset(changeset, [:address, :city, :zip], :latitude, :longitude)
    assert Ecto.Changeset.get_field(changeset, :latitude)
    assert Ecto.Changeset.get_field(changeset, :longitude)
  end

  test "add_geo_coordinates_to_changeset adds latitude and longitude to a changeset from the first result" do
    changeset = Location.changeset(%Location{}, %{address: "74 High Street", city: "New Haven", state: "CT", zip: "06520"})
    changeset = add_geo_coordinates_to_changeset(changeset, [:address, :city, :state, :zip], :latitude, :longitude)
    assert Ecto.Changeset.get_field(changeset, :latitude)
    assert Ecto.Changeset.get_field(changeset, :longitude)
  end

  test "add_geo_coordinates_to_changeset does not add latitude and longitude if no address params are specified" do
    changeset = Location.changeset(%Location{}, %{address: "74 High Street", city: "New Haven", zip: "06520"})
    changeset = add_geo_coordinates_to_changeset(changeset, [], :latitude, :longitude)
    refute Ecto.Changeset.get_field(changeset, :latitude)
    refute Ecto.Changeset.get_field(changeset, :longitude)
  end

  test "add_geo_coordinates_to_changeset adds latitude and longitude if there is an address change" do
    changeset = Location.changeset(%Location{address: "74 High Street", city: "New Haven", zip: "06520"}, %{address: "25 High Street"})
    changeset = add_geo_coordinates_to_changeset(changeset, [:address, :city, :zip], :latitude, :longitude)
    assert Ecto.Changeset.get_field(changeset, :latitude)
    assert Ecto.Changeset.get_field(changeset, :longitude)
  end

  test "add_geo_coordinates_to_changeset does not add latitude and longitude if there is no address change" do
    changeset = Location.changeset(%Location{address: "74 High Street", city: "New Haven", zip: "06520"}, %{address: "74 High Street", city: "New Haven", zip: "06520"})
    changeset = add_geo_coordinates_to_changeset(changeset, [:address, :city, :zip], :latitude, :longitude)
    refute Ecto.Changeset.get_field(changeset, :latitude)
    refute Ecto.Changeset.get_field(changeset, :longitude)
  end
end
