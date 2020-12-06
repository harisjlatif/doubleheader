defmodule Doubleheader.Repo do
  use Ecto.Repo,
    otp_app: :doubleheader,
    adapter: Ecto.Adapters.Postgres
end
