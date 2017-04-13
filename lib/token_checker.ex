defmodule Slackinator.TokenChecker do
  defmodule InvalidTokenError do
    defexception message: "Invalid token", plug_status: 401
  end

  def init(options), do: options

  def call(conn, _opts) do
    conn |> verify_token!
    conn
  end

  defp verify_token!(conn) do
    unless Enum.member?(valid_tokens, passed_token(conn)), do: raise InvalidTokenError
  end

  defp passed_token(conn) do
    Plug.Conn.fetch_query_params(conn).params["token"]
  end

  defp valid_tokens do
    [
      System.get_env("SM_SLACK_TOKEN"),
      System.get_env("BOOTSY_SLACK_TOKEN")
    ]
  end
end
