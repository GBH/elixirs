defmodule Weather do

  import SweetXml

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    args = OptionParser.parse(argv, switches: [help: :boolean], alias: [h: :help])

    case args do
      {[help: true], _, _} ->
        :help
      {_, [code], _} ->
        code
      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts "usage: weather <code>"
    System.halt(0)
  end

  def process(code) do
    with  {:ok, xml}  <- fetch_xml(code),
          {:ok, data} <- process_xml(xml)
    do
      pretty_print(data)
    else
      {:error, reason} ->
        IO.puts "Shit's fucked: #{reason}"
        System.halt(2)
    end
  end

  def fetch_xml(code) do
    code
      |> url
      |> HTTPoison.get
      |> handle_http_response
  end

  def handle_http_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: _code, body: body}} ->
        {:error, body}
      {:error, %HTTPoison.Error{reason: body}} ->
        {:error, body}
    end
  end

  def url(code) do
    "http://w1.weather.gov/xml/current_obs/#{code}.xml"
  end

  def process_xml(xml) do
    scrap_nodes = ~w(credit credit_URL image suggested_pickup suggested_pickup_period 
      observation_time_rfc822 icon_url_base icon_url_name two_day_history_url ob_url
      disclaimer_url copyright_url privacy_policy_url)

    data = xpath(xml, ~x"/current_observation/*"l, header: ~x"name(.)"S, value: ~x"./text()"S)
      |> Enum.reject(&(&1[:header] in scrap_nodes))

    {:ok, data}
  end

  def pretty_print(data) do
    with  header_width  = column_width(data, :header),
          padded_data   = pad_data(data, header_width)
    do
      for row <- padded_data do
        Map.values(row)
          |> Enum.join(" => ")
          |> IO.puts
      end
    end

    :ok
  end

  def column_width(data, label) do
    data
      |> Enum.map(&String.length(&1[label]))
      |> Enum.max
  end

  def pad_data(data, width) do
    pad_leading = fn(string) ->
      String.pad_leading(string, width)
    end

    data
      |> Enum.map(&(%{
        header: pad_leading.(&1[:header]), 
        value:  &1[:value]
      }))
  end
end
