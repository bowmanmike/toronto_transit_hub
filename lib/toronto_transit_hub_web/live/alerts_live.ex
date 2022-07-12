defmodule TorontoTransitHubWeb.AlertsLive do
  use TorontoTransitHubWeb, :live_view

  alias TorontoTransitHub.Clients.{GoClient, TTCClient, UPExpressClient}

  @impl true
  def mount(_params, _session, socket) do
    # Process.send_after(self(), :get_ttc_alerts, 0)
    # Process.send_after(self(), :get_go_alerts, 0)
    # Process.send_after(self(), :get_up_alerts, 0)

    assigns = %{
      message: "Hello!",
      ttc_alerts: nil,
      # go_alerts: GoClient.alerts(),
      go_alerts: nil,
      # up_alerts: UPExpressClient.alerts()
      up_alerts: nil
    }

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_info(:get_ttc_alerts, socket) do
    %{alerts: alerts} = TTCClient.live_alerts()

    {:noreply, assign(socket, :ttc_alerts, alerts)}
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
