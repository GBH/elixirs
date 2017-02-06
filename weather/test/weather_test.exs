defmodule WeatherTest do
  use ExUnit.Case
  doctest Weather

  import ExUnit.CaptureIO, only: [capture_io: 1]
  import Weather
  import Mock

  @processed_xml [
    %{header: "location",           value: "Denton Municipal Airport, TX"}, 
    %{header: "station_id",         value: "KDTO"}, 
    %{header: "latitude",           value: "33.20505"}, 
    %{header: "longitude",          value: "-97.20061"}, 
    %{header: "observation_time",   value: "Last Updated on Feb 4 2017, 1:53 pm CST"}, 
    %{header: "weather",            value: "Overcast"}, 
    %{header: "temperature_string", value: "49.0 F (9.4 C)"}, 
    %{header: "temp_f",             value: "49.0"}, 
    %{header: "temp_c",             value: "9.4"}, 
    %{header: "relative_humidity",  value: "56"}, 
    %{header: "wind_string",        value: "South at 15.0 MPH (13 KT)"}, 
    %{header: "wind_dir",           value: "South"}, 
    %{header: "wind_degrees",       value: "190"}, 
    %{header: "wind_mph",           value: "15.0"}, 
    %{header: "wind_kt",            value: "13"}, 
    %{header: "pressure_string",    value: "1021.4 mb"}, 
    %{header: "pressure_mb",        value: "1021.4"}, 
    %{header: "pressure_in",        value: "30.16"}, 
    %{header: "dewpoint_string",    value: "34.0 F (1.1 C)"}, 
    %{header: "dewpoint_f",         value: "34.0"}, 
    %{header: "dewpoint_c",         value: "1.1"}, 
    %{header: "windchill_string",   value: "43 F (6 C)"}, 
    %{header: "windchill_f",        value: "43"}, 
    %{header: "windchill_c",        value: "6"}, 
    %{header: "visibility_mi",      value: "10.00"}
  ]

  @printed_xml """
            location => Denton Municipal Airport, TX
          station_id => KDTO
            latitude => 33.20505
           longitude => -97.20061
    observation_time => Last Updated on Feb 4 2017, 1:53 pm CST
             weather => Overcast
  temperature_string => 49.0 F (9.4 C)
              temp_f => 49.0
              temp_c => 9.4
   relative_humidity => 56
         wind_string => South at 15.0 MPH (13 KT)
            wind_dir => South
        wind_degrees => 190
            wind_mph => 15.0
             wind_kt => 13
     pressure_string => 1021.4 mb
         pressure_mb => 1021.4
         pressure_in => 30.16
     dewpoint_string => 34.0 F (1.1 C)
          dewpoint_f => 34.0
          dewpoint_c => 1.1
    windchill_string => 43 F (6 C)
         windchill_f => 43
         windchill_c => 6
       visibility_mi => 10.00
  """

  test "parse_args with -h" do
    assert parse_args(["-h", "whatever"])     == :help
    assert parse_args(["--help", "whatever"]) == :help
  end

  test "parse_args with code" do
    assert parse_args(["ABCD"]) == "ABCD"
  end

  test "parse_args with invalid input" do
    assert parse_args(["A", "B"]) == :help
  end

  test "process with :help" do
    result = capture_io fn ->
    with_mock System, [halt: fn(_) -> true end] do
        process(:help)
      end
    end
    assert result == "usage: weather <code>\n"
  end

  test "url" do
    assert url("ABC") == "http://w1.weather.gov/xml/current_obs/ABC.xml"
  end

  test "handle_http_response" do
    response = {:ok, %HTTPoison.Response{status_code: 200, body: "xml"}}
    assert handle_http_response(response) == {:ok, "xml"}

    response = {:ok, %HTTPoison.Response{status_code: 500, body: "500"}}
    assert handle_http_response(response) == {:error, "500"}

    response = {:error, %HTTPoison.Error{reason: "error"}}
    assert handle_http_response(response) == {:error, "error"}
  end

  test "fetch_xml" do
    flunk "todo"
  end

  test "process_xml" do
    {:ok, xml_data} = File.read("test/sample.xml")
    assert process_xml(xml_data) == @processed_xml
  end

  test "pretty_print" do
    result = capture_io fn ->
      pretty_print(@processed_xml)  
    end
    assert result == @printed_xml
  end

  test "column_width" do
    data = [%{header: "ab"}, %{header: "cdef"}]
    assert column_width(data, :header) == 4
  end

  test "pad_data" do
    data = [%{header: "abc", value: "de"}, %{header: "ab", value: "cde"}]
    assert pad_data(data, 4) == [%{header: " abc", value: "de"}, %{header: "  ab", value: "cde"}]
  end
end
