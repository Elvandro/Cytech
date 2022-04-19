defmodule Cytech.Repo do
  use Ecto.Repo,
    otp_app: :cytech,
    adapter: Ecto.Adapters.Postgres
end
