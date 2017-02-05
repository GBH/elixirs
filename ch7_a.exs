defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head*head | square(tail)]

  def add_1([]), do: []
  def add_1([head | tail]), do: [head+1 | add_1(tail)]

  def map([], _func), do: []
  def map([head|tail], func), do: [func.(head) | map(tail, func)]

  def sum(list), do: _sum(list, 0)

  def _sum([], total), do: total
  def _sum([head | tail], total), do: _sum(tail, head + total)
end

list = [1,2,3,4]
IO.puts MyList.len(list)

IO.inspect MyList.square(list)

IO.inspect MyList.add_1(list)

IO.inspect MyList.map(list, fn(n) -> n * 2 end)

IO.inspect MyList.map(list, &(&1 * 3))

IO.inspect MyList.sum(list)