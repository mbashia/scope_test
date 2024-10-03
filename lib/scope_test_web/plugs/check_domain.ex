defmodule ScopeTestWeb.Plugs.CheckDomain do
  @moduledoc """
  Renders WhyElixirLive if the request host is any of the specified hosts.
  """
  import Phoenix.LiveView.Controller
  import Plug.Conn

  alias ScopeTestWeb.DefaultDomainLive

  @type conn :: Plug.Conn.t()

  @spec init(any()) :: []
  def init(_default), do: []

  @spec call(conn(), any()) :: conn()
  def call(conn, _opts) do
    if IO.inspect(host_match?(conn.host)) do
      conn
      |> live_render(DefaultDomainLive)
      |> halt()
    else
      conn
    end
  end

  defp host_match?(host) do
    cond do
      # Match host that starts with a period (e.g., ".example.com")
      Regex.match?(~r/^\..+/, host) -> true
      true -> false
    end
  end
end
