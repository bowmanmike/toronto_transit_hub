defmodule TorontoTransitHubWeb.AlertsLive do
  use TorontoTransitHubWeb, :live_view

  alias TorontoTransitHub.Clients.{GoClient, TTCClient, UPExpressClient}

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :get_ttc_alerts, 0)
    # Process.send_after(self(), :get_go_alerts, 0)
    # Process.send_after(self(), :get_up_alerts, 0)

    assigns = %{
      ttc_alerts: nil,
      go_alerts: nil,
      up_alerts: nil,
      last_updated: nil
    }

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_info(:get_ttc_alerts, socket) do
    %{alerts: alerts, last_updated: last_updated} = TTCClient.live_alerts()

    socket = socket |> assign(:ttc_alerts, alerts) |> assign(:last_updated, last_updated)
    {:noreply, socket}
  end

  def handle_info(:get_go_alerts, socket) do
    %{alerts: alerts} = GoClient.alerts()

    {:noreply, assign(socket, :go_alerts, alerts)}
  end

  def handle_info(:get_up_alerts, socket) do
    %{alerts: alerts} = UPExpressClient.alerts()

    {:noreply, assign(socket, :up_alerts, alerts)}
  end
end
