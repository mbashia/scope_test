defmodule ScopeTest.Repo do
  use Ecto.Repo,
    otp_app: :scope_test,
    adapter: Ecto.Adapters.MyXQL
end
