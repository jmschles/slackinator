defmodule Slackinator.Router do
  use Plug.Router
  require Logger

  plug Slackinator.TokenChecker
  plug Slackinator.ResponsePicker

  plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(Slackinator.Router, [])
  end

  get "/woo" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, encoded_woo_response(conn))
  end

  get _ do
    conn
    |> send_resp(200, "Elixir server reached")
  end

  defp encoded_woo_response(conn) do
    Poison.Encoder.encode(%{text: conn.assigns[:response], response_type: "in_channel"}, [])
  end
end
