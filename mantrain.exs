defmodule ManTrain do

  @speed 2000

  def join do
    caboose_pid = :global.whereis_name(:caboose)
    car_pid = spawn_link(__MODULE__, :choo, [caboose_pid])
    send car_pid, {:start_the_train}
  end

  # Stationary train with only engine. Let's get it moving
  def start_the_train(:undefined) do
    :global.register_name(:caboose, self())
    send self(), {:choo}
  end

  # Train is already chugging along
  def start_the_train(_caboose_pid) do
    :global.re_register_name(:caboose, self())
  end

  def choo(pid, counter \\ 0) do
    receive do
      {:choo} ->
        IO.puts "#{counter} Choo choo! says #{inspect self()}"
        :timer.sleep(@speed)
        bump_forward(pid)
        choo(pid, counter + 1)
      {:start_the_train} ->
        start_the_train(pid)
        choo(pid, counter + 1)
    end
  end

  defp bump_forward(:undefined) do
    send :global.whereis_name(:caboose), {:choo}
  end

  defp bump_forward(pid) do
    send pid, {:choo}
  end
end
