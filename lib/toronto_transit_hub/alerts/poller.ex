defmodule TorontoTransitHub.Alerts.Poller do
  use GenServer

  alias TorontoTransitHub.Alerts.State
  alias TorontoTransitHub.Clients.{GoClient, TTCClient}

  @poll_interval 5 * 60 * 1000

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(_args) do
    Process.send_after(self(), :poll_ttc, 0)
    Process.send_after(self(), :poll_go, 0)

    {:ok, nil}
  end

  @impl true
  def handle_info(:poll_ttc, state) do
    alerts = TTCClient.live_alerts()

    State.update_ttc_alerts(alerts)

    schedule_poll(:ttc)
    {:noreply, state}
  end

  @impl true
  def handle_info(:poll_go, state) do
    alerts = GoClient.alerts()

    State.update_go_alerts(alerts)

    schedule_poll(:go)
    {:noreply, state}
  end

  defp schedule_poll(:ttc) do
    Process.send_after(self(), :poll_ttc, @poll_interval)
  end

  defp schedule_poll(:go) do
    Process.send_after(self(), :poll_go, @poll_interval)
  end
end
