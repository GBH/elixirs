defmodule Issues.TableFormatter do
  
  def pretty_print(rows, headers) do

    # filtering out keys we don't want
    rows = Enum.map(rows, &Map.take(&1, headers))

    # figuring out column widths
    headers_with_widths = get_header_widths(rows, headers)

    # printing headers
    for {header, width} <- headers_with_widths do 
      String.pad_trailing(header, width)
    end
    |> print_line

    # printing line
    for {_header, width} <- headers_with_widths do
      String.duplicate("-", width)
    end
    |> print_line("-+-")

    # printing actual issues
    for row <- rows do
      for {header, width} <- headers_with_widths do
        String.pad_trailing(inspect(row[header]), width)
      end  
      |> print_line
    end

    :ok
  end

  defp get_header_widths(rows, headers) do
    for header <- headers, into: %{} do
      max_width = rows
      |> Enum.map(&String.length(inspect(Map.get(&1, header))))
      |> Enum.max

      header_width = String.length(header)
      
      max_width = if header_width > max_width do
        header_width
      else
        max_width
      end

      {header, max_width}
    end
  end

  defp print_line(values, separator \\ " | ") do
    values
    |> Enum.join(separator)
    |> IO.puts
  end
end
