defmodule MyList do
  def primes(from, to) do
    is_prime? = fn(number) ->
      Enum.empty?(for div <- 2 .. number - 1, rem(number, div) == 0, do: div)
    end
    for number <- from .. to, is_prime?.(number), do: number
  end
end

IO.inspect(MyList.primes(500, 1000))