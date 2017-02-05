times_2 = fn(n) ->
  n * 2
end

apply = fn(function, value) ->
  function.(value)
end

IO.puts apply.(times_2, 6)



list = [1,2,5,7,9]

multiplier = fn(n) ->
  n * 2
end

size_checker = fn(n) ->
  n > 6
end


IO.puts inspect Enum.map list, multiplier
IO.puts inspect Enum.map list, size_checker