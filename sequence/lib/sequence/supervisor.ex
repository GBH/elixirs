defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, supervisor_pid} = Supervisor.start_link(__MODULE__, [initial_number], name: __MODULE__)
    start_workers(supervisor_pid, initial_number)
    result
  end

  def start_workers(supervisor_pid, initial_number) do
    # Starting stash worker
    {:ok, stash_pid} = Supervisor.start_child(
      supervisor_pid,
      worker(Sequence.Stash, [initial_number])
    )

    # Starting supervisor of server process
    Supervisor.start_child(
      supervisor_pid,
      supervisor(Sequence.SeqSupervisor, [stash_pid])
    )
  end


  # seems by doing `use Supervisor` this method will trigger.
  # I guess I'll learn wtf `use` actually does later
  def init(_) do
    # starting supervisor, but no processes to supervise yet
    supervise [], strategy: :one_for_one
  end
end