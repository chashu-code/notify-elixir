defmodule Notifier do
  use GenServer


  def start_link(adapter) do
    GenServer.start_link(__MODULE__, adapter, [name: :notifier])
  end

  def init(adapter) do
    :erlang.process_flag(:trap_exit, true)
    {:ok, adapter}
  end

  def handle_info({:notify, title, text}, adapter) do
    adapter.notify title, text
    {:noreply, adapter}
  end

end