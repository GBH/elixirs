defmodule FizzBuzz do
  
  def upto(n) do
    1..n |>
    Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    case {rem(n, 3), rem(n, 5), n} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      _         -> n
    end
  end
end

IO.inspect(FizzBuzz.upto(25))