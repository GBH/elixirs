defmodule Ticker do

  @interval 2000 # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator(List.insert_at(clients, -1, pid))
    after
      @interval ->
        IO.puts "tick"

        cycled_clients = cycle_clients(clients)
        notify_client(List.first(cycled_clients))

        generator(cycled_clients)
    end
  end

  defp cycle_clients([]), do: []
  defp cycle_clients([current | rest]) do
    List.insert_at(rest, -1, current)
  end

  defp notify_client(nil), do: nil
  defp notify_client(client) do
    send client, {:tick}
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver()
    end
  end
end