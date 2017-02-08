defmodule Counter do
  def count do
    receive do
      {sender, count} ->
        # we can simulate random execution times
        # :timer.sleep(:rand.uniform(1000))
        send sender, {:ok, count}
        count()
    end
  end
end

Enum.each(1..100, fn(n) ->
  pid = spawn(Counter, :count, [])
  send pid, {self(), n}

  # This will wait to receive after spawn (will be in order)
  # receive do
  #   {:ok, message} ->
  #     IO.puts message
  # end
end)


# Receiving out of order
Enum.each(1..100, fn(_) ->
  receive do
    {:ok, message} ->
      IO.puts message
  end
end)
