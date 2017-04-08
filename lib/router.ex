
defmodule Slackinator.Router do
  use Plug.Router
  require Logger

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
    |> send_resp(200, "{\"text\": \"ᕕ( ᐛ )ᕗ}\", \"response_type\": \"in_channel\"}")
  end

  get "/" do
    conn
    |> send_resp(200, "Elixir server reached")
  end
end
