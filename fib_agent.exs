defmodule FibAgent do

  def init_cache do
    Agent.start_link(
      fn -> %{0 => 0, 1 => 1} end
    )
  end

  def fib(cache, n) when n >= 0 do
    Agent.get_and_update(cache, &do_fib(&1, n))
  end

  defp do_fib(cache, n) do
    case cache[n] do
      nil ->
        {n_1, cache} = do_fib(cache, n - 1)
        result = n_1 + cache[n - 2]
        {result, Map.put(cache, n, result)}

      cached_value ->
        {cached_value, cache}
    end
  end
end

{:ok, cache} = FibAgent.init_cache()
IO.puts FibAgent.fib(cache, 2000)