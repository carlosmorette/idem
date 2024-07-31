defmodule Idem.IdempotencyPlug do
  @behaviour Plug
  import Plug.Conn
  alias Idem.Clients.Redis

  @header "idempotency-key"
  @expiration_in_seconds 15

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, @header) do
      [] -> stop(conn, "Missing header: #{@header}")
      [key] -> handle_key(conn, key)
    end
  end

  def handle_key(conn, key) do
    if Redis.get_key(key: key) do
      stop(conn, "Can't perform operation")
    else
      now = :os.system_time(:millisecond)
      Redis.put_async(key: key, value: now, expiration: @expiration_in_seconds)
      conn
    end
  end

  def stop(conn, reason) when is_binary(reason) do
    send_resp(conn, :bad_request, Jason.encode!(%{error: reason, node: node()}))
    |> halt()
  end
end
