defmodule Test do

  def what(parent) do
    send parent, {:ok, "you win"}
    raise "hello"
    # exit(:boom)
  end
end

spawn_monitor(Test, :what, [self()])

:timer.sleep(1000)

receive do
  {:ok, message} ->
    IO.puts message
end