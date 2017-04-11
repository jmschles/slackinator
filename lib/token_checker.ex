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
    unless passed_token(conn) == correct_token(), do: raise InvalidTokenError
  end

  defp passed_token(conn) do
    Plug.Conn.fetch_query_params(conn).params["token"]
  end

  defp correct_token do
    System.get_env("SLACK_TOKEN")
  end
end
