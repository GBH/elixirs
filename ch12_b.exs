defmodule Ok do
  
  def ok!(response) do
    case response do
      {:ok, data} ->
        data
      _ ->
        raise "Shit's fucked"
    end
  end
end


file = Ok.ok! File.open("/home/oleg/Code/sales.csv")
IO.inspect(file)