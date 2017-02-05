defmodule Chop do

  def guess(actual, range = low..high) do
    candidate = div(low + high, 2)
    IO.puts "is it #{candidate}?"
    check(actual, candidate, range)
  end

  defp check(actual, candidate, _low..high) when actual > candidate do
    guess(actual, candidate..high)
  end

  defp check(actual, candidate, low.._high) when actual < candidate do
    guess(actual, low..candidate)
  end

  defp check(_actual, _candidate, _range) do
    IO.puts 'Yeah!'
  end

end

Chop.guess(272, 500..1000)