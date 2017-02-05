defmodule Times do
  def double(n) do
    n * 2
  end
  
  def triple(n) do
    n * 3
  end
  
  def quads(n) do
    double(n) * 2
  end
  
end

IO.puts Times.quads(5)