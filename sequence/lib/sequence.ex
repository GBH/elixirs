defmodule Sequence do
  use Application

  def start(_type, _args) do
    # Starting main supervisor and sending initial value
    {:ok, _pid} = Sequence.Supervisor.start_link(123)
  end
end
