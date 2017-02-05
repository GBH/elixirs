defmodule MyList do

  def mapsum([], _fun), do: 0

  def mapsum([head | tail], fun) do
    fun.(head) + mapsum(tail, fun)
  end

  def max([head | _tail] = list), do: _max(list, head)

  def _max([], max), do: max

  def _max([head | tail], max) when head > max do
    _max(tail, head)
  end

  def _max([head | tail], max) when max >= head do
    _max(tail, max)
  end

  def caesar([], offset), do: [ ]

  def caesar([head | tail], offset) when head + offset <= 122 do
    [head + offset | caesar(tail, offset)]
  end

  def caesar([head | tail], offset) when head + offset > 122 do
    wrapback = 26
    [head + offset - wrapback | caesar(tail, offset)]
  end

end


list = [1, 9, 24, 3]

IO.inspect MyList.mapsum(list, &(&1 * &1))

IO.inspect MyList.max(list)

IO.inspect MyList.caesar('ryvkve', 13)