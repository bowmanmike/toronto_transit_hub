defmodule TorontoTransitHubWeb.Live.Components.TransitServiceDisplay do
  # use TorontoTransitHubWeb, :live_component
  use Phoenix.Component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <heading><%= @service_name %></heading>
      <div>
        <%= unless @alerts do %>
          <TorontoTransitHubWeb.Live.Spinner.render colour={@service_colour} />
        <% else %>
          <p>There are currently <%= length(@alerts) %> active alerts on the TTC.</p>
          <%= for alert <- @alerts do %>
            <div class="rounded border-gray-200 border shadow-md w-1/4 p-2 m-2">
              <p><%= alert.title %></p>
              <p>Affecting these routes: <%= alert.route %></p>
            </div>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  # @impl true
  # def update(assigns, socket) do
  #   IO.inspect(assigns, label: :update)
  #   IO.puts(:"get_#{String.downcase(assigns.service_name)}_alerts")
  #   # Process.send_after(self(), :"get_#{String.downcase(assigns.service_name)}_alerts", 0)
  #   socket = socket |> assign(assigns) |> assign(:alerts, nil)

  #   {:ok, assign(socket, assigns)}
  # end

  # def handle_info(:get_service_alerts, %{assigns: assigns} = socket) do
  #   %{client_module: client_module, service_name: service_name} = assigns
  #   %{alerts: alerts} = client_module.alerts()

  #   {:noreply, assign(socket, :"#{String.downcase(service_name)}_alerts", alerts)}
  # end
end
