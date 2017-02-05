add_one_a = fn(n) ->
  n + 1
end

add_one_b = &(&1 + 1)

IO.puts add_one_a.(99)
IO.puts add_one_b.(66)