defmodule Notify do
  use Application

  def start(_type, _args) do
    {:ok, _} = NotifySup.start_link
  end

  def notify(title, text \\ "") do
    send :notifier, {:notify, title, text}
  end

end
