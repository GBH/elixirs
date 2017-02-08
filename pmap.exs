defmodule Parallel do

  def pmap(collection, fun) do
    me = self()

    collection
      |> Enum.map(
        fn(element) ->
          spawn_link(fn -> (send(me, {self(), fun.(element)})) end)
        end
      )
      |> Enum.map(
        fn(pid) ->
          receive do
            {^pid, result} ->
              result
          end
        end
      )
  end

end


list = 1..1000
IO.inspect Parallel.pmap list, &(&1 + 1)