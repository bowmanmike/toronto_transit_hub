defmodule TorontoTransitHub.Repo do
  use Ecto.Repo,
    otp_app: :toronto_transit_hub,
    adapter: Ecto.Adapters.Postgres
end
