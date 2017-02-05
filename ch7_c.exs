defmodule MyList do

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

end

list = [1,2,3,4]
IO.inspect MyList.reduce list, 1, &(&1 * &2)