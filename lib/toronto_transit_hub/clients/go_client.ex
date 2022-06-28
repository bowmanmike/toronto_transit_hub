defmodule TorontoTransitHub.Clients.GoClient do
  @alerts_url "https://api.gotransit.com/Api/ServiceUpdate/en/all"

  def alerts do
    @alerts_url
    |> Req.get!()
    |> parse_response()
  end

  defp parse_response(%Req.Response{body: data}) do
    %{
      last_updated: data["LastUpdated"],
      alerts: parse_alerts(data)
    }
  end

  defp parse_alerts(data) do
    res =
      data
      |> Map.take(["Trains", "Buses", "Stations"])
      |> Enum.flat_map(fn
        {_k, %{"TotalUpdates" => 0}} ->
          []

        {k, v} ->
          flatten_alerts(k, v)
          |> Enum.map(fn alert ->
            %{
              route_name: alert["RouteName"],
              route_number: alert["RouteNumber"]
            }
          end)
      end)

    # require IEx
    # IEx.pry()
    res
  end

  defp flatten_alerts("Buses", bus_alerts), do: bus_alerts["Bus"]
  defp flatten_alerts("Trains", train_alerts), do: train_alerts["Train"]
  defp flatten_alerts("Stations", station_alerts), do: station_alerts["Station"]
end
