defmodule Sequence do
  use Application

  def start(_type, _args) do
    # Starting main supervisor and sending initial value
    {:ok, _pid} = Sequence.Supervisor.start_link(Application.get_env(:sequence, :initial_number))
  end
end
