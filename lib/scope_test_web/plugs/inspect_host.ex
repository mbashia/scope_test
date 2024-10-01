defmodule ScopeTestWeb.Plugs.InspectHost do
    import Plug.Conn
  
    def init(opts), do: opts
  
    def call(conn, _opts) do
      host = conn.host
      IO.puts("Host: #{host}")  # Inspect or log the host
      
      conn
    end
  end