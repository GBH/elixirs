defmodule Example do
  
  def func(p1, p2 \\ "Y", p3 \\ "Z", p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a", "b")
Example.func("a", "b", "c")
Example.func("a", "b", "c", "d")