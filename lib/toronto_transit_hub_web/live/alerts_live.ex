defmodule TorontoTransitHubWeb.AlertsLive do
  use TorontoTransitHubWeb, :live_view

  alias TorontoTransitHub.Alerts.State
  alias TorontoTransitHub.Clients.{GoClient, TTCClient, UPExpressClient}

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign_ttc_alerts()
    |> assign_go_alerts()
    |> reply_ok()
  end

  defp assign_ttc_alerts(socket) do
    %{alerts: alerts, last_updated: last_updated} = State.ttc_alerts()

    socket
    |> assign(:ttc_alerts, alerts)
    |> assign(:ttc_last_updated, last_updated)
  end

  defp assign_go_alerts(socket) do
    %{alerts: alerts, last_updated: last_updated} = State.go_alerts()

    socket
    |> assign(:go_alerts, alerts)
    |> assign(:go_last_updated, last_updated)
  end
end
