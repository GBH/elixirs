defmodule MyString do

  def is_printable?(string) do
    Enum.all?(string, &(&1 in ?\s..?~))
  end

  def is_anagram?(string_a, string_b) do
    Enum.sort(string_a) == Enum.sort(string_b)
  end

  def calculate(expression) do
    {expression, x} = _parse_number(expression, 0)
    expression = trim_space(expression)
    [operator | expression] = expression
    expression = trim_space(expression)
    {_, y} = _parse_number(expression, 0)
    _calculate(x, operator, y)
  end

  def _calculate(x, ?+, y), do: x + y
  def _calculate(x, ?-, y), do: x - y
  def _calculate(x, ?*, y), do: x * y
  def _calculate(x, ?/, y), do: x / y

  def trim_space([?\s | expression]), do: trim_space(expression)
  def trim_space(expression), do: expression

  def _parse_number([], number) do
    {[], number}
  end

  def _parse_number([char | rest], number) when char in ?0..?9 do
    _parse_number(rest, number*10 + char - ?0)
  end

  def _parse_number(rest, number) do
    {rest, number}
  end
	
end

IO.inspect(MyString.calculate('5 * 5'))
# IO.inspect(MyString.is_anagram?('cat', 'tco')) 
# IO.inspect(MyString.is_printable?('faggot'))