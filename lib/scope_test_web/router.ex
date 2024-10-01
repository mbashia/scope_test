defmodule ScopeTestWeb.Router do
  use ScopeTestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ScopeTestWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ScopeTestWeb.Plugs.InspectHost  # Add the custom plug to inspect the host

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScopeTestWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/scope_test", ScopeTestWeb do
    pipe_through :browser
    live "/main_domain", MainDomainLive.Index, :index
    live "/other_domain", OtherDomainLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScopeTestWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:scope_test, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ScopeTestWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
