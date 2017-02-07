defmodule Factorial do

  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)

end

defmodule FactorialTail do

  def fact(n), do: _fact(n, 1)
  def _fact(0, acc), do: acc
  def _fact(n, acc), do: _fact(n - 1, acc * n)

end

# IO.inspect(Factorial.fact(100_000))

IO.inspect(FactorialTail.fact(100_000))