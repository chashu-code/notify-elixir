# Notify

**Notify to User**

## Installation

  1. Add notify to your list of dependencies in `mix.exs`:

        def deps do
          [{:notify, git: "https://github.com/chashu-code/job-scheduler.git"}]
        end

  2. Ensure notify is started before your application:

        def application do
          [applications: [:notify]]
        end

## Config

  1. add notify config in `config/config.exs`

        config :notify,
          adapter: Notify.Adapter.Incoming

        config :notify, :incoming,
          webhook_url: "https://hook.bearychat.com/{{your webhook url}}"

## API

    Notify.notify(title, text)
    # title: String
    # text: String
