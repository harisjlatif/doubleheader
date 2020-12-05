defmodule Skore.Repo do
  use Ecto.Repo,
    otp_app: :skore,
    adapter: Ecto.Adapters.Postgres
end
