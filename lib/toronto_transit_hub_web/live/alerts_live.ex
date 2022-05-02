defmodule TorontoTransitHubWeb.AlertsLive do
  use TorontoTransitHubWeb, :live_view

  alias TorontoTransitHub.Clients.TTCClient

  @impl true
  def mount(_params, _session, socket) do
    assigns = %{
      message: "Hello!",
      ttc_alerts: TTCClient.live_alerts(),
      go_alerts: [],
      up_alerts: []
    }

    {:ok, assign(socket, assigns)}
  end
end
