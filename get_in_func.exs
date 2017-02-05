authors = [
  %{ name: "José", language: "Elixir" },
  %{ name: "Matz", language: "Ruby" },
  %{ name: "Larry", language: "Perl" }
]

langs_with_r = fn(:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [langs_with_r, :name])