list_concat = fn(a, b) -> a ++ b end

r = list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]
IO.puts inspect r

sum = fn(a,b,c) ->
  a + b + c 
end
r = sum.(1, 2, 3) #=> 6
IO.puts inspect r


pair_tuple_to_list = fn({h, t}) ->
  [h, t]
end

r = pair_tuple_to_list.( { 1234, 5678 } ) #=> [ 1234, 5678 ]
IO.puts inspect r