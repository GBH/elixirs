add_n = fn(n) ->
  fn(other) ->
    n + other
  end
end

add_two_and = add_n.(2)
add_five_and = add_n.(5)

IO.puts add_two_and.(3)
IO.puts add_five_and.(3)