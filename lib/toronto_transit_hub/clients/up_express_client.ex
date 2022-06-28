defmodule TorontoTransitHub.Clients.UPExpressClient do
  @base_url "https://www.upexpress.com/SchedulesStations/ServiceStatus"

  def alerts do
    @base_url
    |> Req.get!()
    |> parse_response()
  end

  defp parse_response(%Req.Response{body: data, status: 200}) do
    res = data
    |> Floki.parse_document!()
    |> Floki.find("#serviceStatusLeftMargin")
    |> Floki.find("h3 ~ div")
    |> Floki.text()
    |> String.trim()
    |> String.split("\r\n")
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [first, second] ->
      [station, date] = String.split(first, " Station")
      # probably need to use timex to parse the datetime
    end)

    require IEx
    IEx.pry()
    res
  end
end
