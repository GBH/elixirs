defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

defmodule Main do
  def run do
    s1 = %Subscriber{}
    IO.inspect(s1)
  end
end

Main.run()