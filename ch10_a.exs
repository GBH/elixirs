# all?
require Integer

defmodule MyEnum do


  def all?([], _), do: true

  def all?([head | tail], func) do
    func.(head) and all?(tail, func)
  end


  def each([], _), do: :ok

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _), do: []

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, 0) do
    {[], list}
  end

  def split([], _) do
    {[], []}
  end

  def split(list, count) when count < 0 do
    count = -count
    list = Enum.reverse(list)
    {a, b} = split(list, count)
    {Enum.reverse(b), Enum.reverse(a)}
  end

  def split([head | tail], count) do
    {[head | elem(split(tail, count - 1), 0)], elem(split(tail, count - 1), 1)}
  end

  
  def take(_list, 0), do: []

  def take(list, count) when count < 0 do
    Enum.reverse(take(Enum.reverse(list), -count))
  end

  def take([head | tail], count) do
    [head | take(tail, count - 1)]
  end

  def take(_, _), do: []


  def flatten(list) do
    do_flatten(list, [])
  end

  def do_flatten([h | t], tail) when is_list(h) do
    do_flatten(h, do_flatten(t, tail))
  end


  def do_flatten([h | t], tail) do
    [h | do_flatten(t, tail)]
  end

  def do_flatten([], tail) do
    tail
  end

end

list = [9,[1],2,3]

IO.inspect(MyEnum.flatten(list))

# list = [1,2,3,4,5]

# list = [2,4,6]
# IO.inspect(MyEnum.all?(list, &Integer.is_even/1))

# MyEnum.each(list, &IO.inspect/1)

# IO.inspect MyEnum.filter(list, &Integer.is_odd/1)

# IO.inspect(MyEnum.split(list, -10))

# IO.inspect(MyEnum.take(list, -3))