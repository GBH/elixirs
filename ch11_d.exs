defmodule FileProcessor do

  @tax_rates [NC: 0.075, TX: 0.08]

  def parse_file(filename) do
    File.open!(filename) |>
    IO.stream(:line) |>
    Enum.drop(1) |>
    Enum.map(&parse_line(&1))
  end

  defp parse_line(line) do
    [id, ship_to, net_amount] = String.split(line, ",")
    {id, _}         = Integer.parse(id)
    ship_to         = String.to_atom(String.trim_leading(ship_to, ":"))
    {net_amount, _} = Float.parse(net_amount)

    tax = Keyword.get(@tax_rates, ship_to, 0)
    total_amount = net_amount * (1 + tax)

    [id: id, ship_to: ship_to, net_amount: net_amount, total_amount: total_amount]
  end
end

IO.inspect FileProcessor.parse_file("/home/oleg/Code/sales.csv")