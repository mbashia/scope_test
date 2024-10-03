defmodule ScopeTestWeb.Plugs.InspectHost do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    host = conn.host
    # Inspect or log the host
    IO.puts("Host: #{host}")

    conn
  end
end
