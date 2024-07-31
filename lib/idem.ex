defmodule Idem do
  @suffix "IDEM_KEY:"

  @doc """
  Function to create a unique identifier for a financial transaction.
  """
  @spec create_key(String.Chars.t(), String.Chars.t()) :: String.t()
  def create_key(user_id, payment_amount) do
    string = "#{@suffix}:#{user_id}:#{payment_amount}"

    :md5
    |> :crypto.hash(string)
    |> Base.encode64()
  end
end
