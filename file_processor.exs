defmodule DeFinder do

  def find(caller) do
    # IO.puts "Process #{inspect self()}: Ready to work"

    send caller, {:ready, self()}

    receive do

      {:find, counter, filename} ->
        # IO.puts "Process #{inspect self()}: Returning result"
        send caller, {:result, {counter, find_in(filename)}, self()}
        find(caller)

      {:shutdown} ->
        # IO.puts "Process #{inspect self()}: Shutting down"
        exit(:normal)
    end
  end

  defp find_in(filename) do
    text = File.read!(filename)
    # This is way too fast
    :timer.sleep(10)
    {filename, length(Regex.scan(~r/def/, text))}
  end
end

defmodule Scheduler do

  def run(number_of_processes, module, func, queue) do
    (1..number_of_processes)
      |> Enum.map(fn(_) -> spawn_link(module, func, [self()]) end)
      |> schedule(queue)
  end

  def schedule(processes, queue, results \\ []) do

    receive do

      {:ready, pid} when length(queue) == 0 ->
        # IO.puts "Scheduler: No more items in queue. Asking process to shutdown"
        send pid, {:shutdown}


        if length(processes) > 1 do
          # if there are still processes kicking about, we need to wait until they are done
          schedule(List.delete(processes, pid), queue, results)
        else
          # because results can come in any order, we'll sort them using counter
          # number we attached to result data
          results
            |> Enum.sort(fn({n1, _}, {n2, _}) -> n1 >= n2 end)
            |> Enum.map(fn({_counter, result}) -> result end)
        end

      {:ready, pid} ->
        # IO.puts "Scheduler: Sending item from queue to process"

        counter = length(queue)
        [current | rest] = queue

        # doing the countdown so we can reorder results later
        send pid, {:find, counter, current}

        schedule(processes, rest, results)


      {:result, result, _pid} ->
        # IO.puts "Scheduler: Received result"
        schedule(processes, queue, [result | results])

      _ ->
        raise "Unexpected message"

    end
  end
end

filenames = Path.wildcard("**/*.{exs,ex}")

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run, [num_processes, DeFinder, :find, filenames]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end

  :io.format "~2B     ~.10f~n", [num_processes, time/1_000_000.0]
end
