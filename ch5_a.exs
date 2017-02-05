# greeter = fn ->
#   fn ->
#     "Hello"
#   end
# end
#
# IO.puts inspect greeter.().()


greeter = fn(name) ->
  fn ->
    "Hello #{name}"
  end
end

dave_greeter = greeter.("Dave")

IO.puts dave_greeter.()


