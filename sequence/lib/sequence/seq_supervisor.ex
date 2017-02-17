defmodule Sequence.SeqSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def init(stash_pid) do
    workers = [
      worker(Sequence.Server, [stash_pid])
    ]
    supervise workers, strategy: :one_for_one
  end
end