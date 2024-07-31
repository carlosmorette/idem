defmodule Idem.Clients.Redis do
  use GenServer

  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{conn: nil}, name: __MODULE__)
  end

  def init(_state) do
    config = config()
    {:ok, conn} = Redix.start_link(host: config[:host], port: config[:port])
    {:ok, %{conn: conn}}
  end

  def handle_call({:get_key, key} = params, _from, %{conn: conn} = state) do
    log_called(params)
    {:ok, value} = Redix.command(conn, ["GET", key])
    {:reply, value, state}
  end

  def handle_cast({:put_key, key, value, expiration} = params, %{conn: conn} = state) do
    log_called(params)
    {:ok, _value} = Redix.command(conn, ["SET", key, value, "EX", expiration])
    {:noreply, state}
  end

  ## Public API
  def get_key(key: key) do
    GenServer.call(__MODULE__, {:get_key, key})
  end

  def put_async(key: key, value: value, expiration: expiration) do
    GenServer.cast(__MODULE__, {:put_key, key, value, expiration})
  end

  ## Helpers
  defp config, do: Application.get_env(:idem, __MODULE__)

  def log_called(params) do
    Logger.info("""
    [#{__MODULE__}] Called
    params: #{inspect(params)}
    node: #{node()}
    """)
  end
end
