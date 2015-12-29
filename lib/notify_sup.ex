defmodule NotifySup do
  use Supervisor

  def start_link(opts \\ [name: :notify_sup]) do
    Supervisor.start_link(__MODULE__, [], opts)
  end

  def init(_conf) do
    children = case Application.get_env(:notify, :adapter) do
      nil -> []
      adapter ->
        if adapter do
          :crypto.start() # when request https
          [worker(Notifier, [adapter])]
        else
          []
        end
    end

    supervise(children, strategy: :one_for_one)
  end
end