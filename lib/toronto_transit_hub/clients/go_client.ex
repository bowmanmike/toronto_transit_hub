defmodule TorontoTransitHub.Clients.GoClient do
  alias TorontoTransitHub.Alert

  @alerts_url "https://api.gotransit.com/Api/ServiceUpdate/en/all"

  def alerts do
    @alerts_url
    |> Req.get!()
    |> parse_response()
  end

  defp parse_response(%Req.Response{body: data}) do
    # TODO: this is showing the time in UTC not our timezone
    {_, timestamp, _} = DateTime.from_iso8601(data["LastUpdated"])

    %{
      last_updated: timestamp,
      alerts: parse_alerts(data)
    }
  end

  defp parse_alerts(data) do
    data
    |> Map.take(["Trains"])
    |> Enum.flat_map(fn
      {_k, %{"TotalUpdates" => 0}} ->
        []

      {k, v} ->
        flatten_alerts(k, v)
        |> Enum.flat_map(fn
          %{"Notifications" => %{"Notification" => []}} ->
            []

          %{"Notifications" => %{"Notification" => notifications}} = alert ->
            notifications
            |> Enum.map(fn notif ->
              attrs = %{
                routes: alert["CorridorName"],
                title: notif["MessageSubject"]
              }

              Alert.changeset(%Alert{}, attrs)
            end)
        end)
    end)
  end

  defp flatten_alerts("Buses", bus_alerts), do: bus_alerts["Bus"]
  defp flatten_alerts("Trains", train_alerts), do: train_alerts["Train"]
  defp flatten_alerts("Stations", station_alerts), do: station_alerts["Station"]
end
