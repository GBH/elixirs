defmodule Countdown do

  def sleep(seconds) do
    receive do
      after seconds * 1000 -> nil
    end
  end

  def say(text) do
    IO.puts text
  end


  def timer do
    start_fun = fn ->
      {_h, _m, s} = :erlang.time
      60 - s - 1
    end

    next_fun = fn
      0 ->
        {:halt, 0}
      count ->
        sleep(1)
        { [inspect(count)], count - 1}
    end

    end_fun = fn _ ->  
      nil 
    end

    Stream.resource(start_fun, next_fun, end_fun)
  end
 
end