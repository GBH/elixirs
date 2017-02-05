defmodule Swapper do

  def swap([]), do: []

  def swap([a, b | tail]) do
    [b, a | swap(tail)]
  end

  def swap([_]), do: raise "Can't swap odd list"

end

list = [1,2,3,4]

IO.inspect Swapper.swap list