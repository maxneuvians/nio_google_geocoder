defmodule NioGoogleGeocoderTest do
  use ExUnit.Case
  import NioGoogleGeocoder

  test "geocode takes a string and returns {:ok, [result]} if the geocode is succesfull" do
    assert {:ok, [_result]} = geocode("767 Weston Drive")
  end

  test "geocode can take a list of strings and returns a list if the geocode is succesfull" do
    assert [_h|_t] = geocode( ["767 Weston Drive", "149 Fifth Ave."] )
  end

  test "geocode requires either a string or a list" do
    assert {:error, _} = geocode(1)
  end

  test "geocode returns an empty list if no result is found" do
    assert {:ok, []} = geocode("asdasdasdasdasd")
  end
end
