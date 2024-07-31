defmodule Idem.Router do
  use Plug.Router

  plug(Idem.IdempotencyPlug)
  plug(:match)
  plug(:dispatch)

  post "/perform" do
    send_resp(conn, :ok, "performed operation with success!")
  end

  match _ do
    send_resp(conn, :not_found, "")
  end
end
