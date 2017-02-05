defmodule MyString do
  
  def center(list) do
    max_length = list |>
      Enum.map(&String.length/1) |>
      Enum.max 

    offset = fn(string) ->
      length = String.length(string)
      div(max_length - length, 2) + length 
    end

    list |>
    Enum.map(&String.pad_leading(&1, offset.(&1))) |>
    Enum.each(&IO.puts/1)
  end

  def capitalize_sentences(string) do
    string |>
    String.split(". ") |>
    Enum.map(&(String.capitalize(&1))) |>
    Enum.join(". ")
  end
end

IO.inspect MyString.capitalize_sentences("oh. a DOG. woof. ")
# MyString.center(["cat", "zébra", "elephant", "1234567890"])

