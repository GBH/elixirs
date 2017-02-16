defmodule StackServer do
  use GenServer

  # -- API ---------------------------------------------------------------------
  def start_link(stack) when is_list(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def shutdown do
    GenServer.cast(__MODULE__, :shutdown)
  end

  # -- GenServer ---------------------------------------------------------------
  def handle_call(:pop, _from, []), do: raise "Empty stack"
  def handle_call(:pop, _from, stack) do
    {value, rest} = List.pop_at(stack, -1)
    {:reply, value, rest}
  end

  def handle_cast({:push, item}, stack) do
    {:noreply, List.insert_at(stack, -1, item)}
  end

  def handle_cast(:shutdown, stack) do
    {:stop, "Got request to shutdown", stack}
  end

  def terminate(reason, _stack) do
    IO.puts "Server terminated because: #{inspect reason}"
  end
end