defmodule TorontoTransitHub.Clients.TTCClient do
  alias TorontoTransitHub.Alert

  @live_alerts_url "https://alerts.ttc.ca/api/alerts/live-alerts"

  def live_alerts do
    @live_alerts_url
    |> Req.get!()
    |> parse_response()
  end

  defp parse_response(%Req.Response{body: data, status: 200}) do
    {:ok, timestamp, _} = parse_last_updated(data["lastUpdated"])

    %{
      last_updated: timestamp,
      alerts: parse_alerts(data)
    }
  end

  def parse_alerts(data) do
    data
    |> Map.take(["routes", "accessibility", "generalCustom", "siteWide", "siteWideCustom"])
    |> Map.values()
    |> Enum.filter(&is_list/1)
    |> Enum.concat()
    |> Enum.map(fn alert ->
      attrs = %{
        accessibility: alert["accessibility"],
        active_period_start: get_in(alert, ["activePeriod", "start"]),
        active_period_end: get_in(alert, ["activePeriod", "end"]),
        alert_type: alert["alertType"],
        description: alert["description"],
        effect: alert["effect"],
        effect_desc: alert["effectDesc"],
        header_text: alert["headerText"],
        id: String.to_integer(alert["id"]),
        last_updated: alert["lastUpdated"],
        priority: alert["priority"],
        routes: alert["route"],
        route_branch: alert["routeBranch"],
        route_type: alert["routeType"],
        route_type_src: alert["routeTypeSrc"],
        severity: alert["severity"],
        severity_order: alert["severityOrder"],
        title: alert["title"],
        url: alert["url"],
        url_placeholder: alert["urlPlaceholder"]
      }

      Alert.changeset(%Alert{}, attrs)
    end)
  end

  defp parse_last_updated(timestamp) do
    case String.ends_with?(timestamp, "Z") do
      true -> timestamp
      false -> "#{timestamp}Z"
    end
    |> DateTime.from_iso8601()
  end
end
