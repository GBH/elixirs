data = %{name: "oleg", state: "TX", likes: "cock"}

huh = for key <- [:name, :likes] do
  %{^key => value} = data
  value
end

IO.inspect(huh)