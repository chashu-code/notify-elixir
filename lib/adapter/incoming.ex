require Lager

defmodule Notify.Adapter.Incoming do

  def notify(title, text) do
    conf = Application.get_env(:notify, :incoming, [])
    url = Keyword.get conf, :webhook_url
    opts = Keyword.get conf, :http_options, [timeout: 2_000, recv_timeout: 3_000]

    body = Poison.encode!(%{
      text: title,
      attachments: [%{
        text: text
      }]
    })

    headers = [{"Content-Type", "application/json"}]

    if url do
      case HTTPoison.request(:post,url,body,headers,opts) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Lager.info "~p.notify success: ~p", [__MODULE__, body]
          true
        error ->
          Lager.error "~p.notify error: ~p", [__MODULE__, error]
          false
      end
    else
      false
    end
  end
end