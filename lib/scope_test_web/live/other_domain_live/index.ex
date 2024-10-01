defmodule ScopeTestWeb.OtherDomainLive.Index do
  use ScopeTestWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
