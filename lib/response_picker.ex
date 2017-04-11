require IEx
defmodule Slackinator.ResponsePicker do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    response = conn
    |> parse_command
    |> pick_response
    |> assign_response(conn)
  end

  def parse_command(conn) do
    fetch_query_params(conn).params["text"]
  end

  def assign_response(response, conn) do
    assign(conn, :response, response)
  end

  def pick_response(command) do
    case command do
      "flip" ->
        "(╯°□°）╯︵ ┻━┻"
      "shrugflip" ->
        "┻━┻ ︵ ¯\\(ツ)/¯ ︵ ┻━┻"
      "flappy" ->
        "ᕕ( ᐛ )ᕗ"
      _ ->
        "¯\\_(ツ)_/¯"
    end
  end
end
