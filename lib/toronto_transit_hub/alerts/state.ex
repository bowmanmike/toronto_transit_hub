defmodule TorontoTransitHub.Alerts.State do
  use Agent

  def start_link(state) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def ttc_alerts do
    Agent.get(__MODULE__, & &1[:ttc])
  end

  def go_alerts do
    Agent.get(__MODULE__, & &1[:go])
  end

  def update_ttc_alerts(data) do
    Agent.update(__MODULE__, fn state -> Map.put(state, :ttc, data) end)
  end

  def update_go_alerts(data) do
    Agent.update(__MODULE__, fn state -> Map.put(state, :go, data) end)
  end
end
