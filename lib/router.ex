
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
    |> send_resp(200, "ᕕ( ᐛ )ᕗ")
  end

  get "/" do
    conn
    |> send_resp(200, "Elixir server reached")
  end
end
