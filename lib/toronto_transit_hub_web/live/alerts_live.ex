defmodule TorontoTransitHubWeb.AlertsLive do
  use TorontoTransitHubWeb, :live_view

  alias TorontoTransitHub.Clients.{GoClient, TTCClient, UPExpressClient}

  @impl true
  def mount(_params, _session, socket) do
    assigns = %{
      message: "Hello!",
      ttc_alerts: TTCClient.live_alerts(),
      go_alerts: GoClient.alerts(),
      up_alerts: UPExpressClient.alerts()
    }

    {:ok, assign(socket, assigns)}
  end
end
