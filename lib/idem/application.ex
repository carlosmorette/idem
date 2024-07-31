defmodule Idem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  require Logger

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:idem, __MODULE__)[:port] |> String.to_integer()

    children = [
      {Plug.Cowboy, plug: Idem.Router, scheme: :http, options: [port: port]},
      Idem.Clients.Redis
    ]

    Logger.info("Plug now running on localhost:#{port}")
    Logger.info("Started node: #{node()}")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Idem.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
