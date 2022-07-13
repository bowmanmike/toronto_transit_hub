defmodule TorontoTransitHubWeb.Live.Components.TransitServiceDisplay do
  # use TorontoTransitHubWeb, :live_component
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div>
      <heading class="text-xl font-semibold"><%= @service_name %></heading>
      <div>
        <%= unless @alerts do %>
          <TorontoTransitHubWeb.Live.Spinner.render colour={@service_colour} />
        <% else %>
          <p class="my-2">
            There are currently
            <span class="italic font-semibold"><%= length(@alerts) %> active alerts</span> on the
            <%= @service_name %>, as of
            <span><%= Calendar.strftime(@last_updated, "%I:%M %P on %A, %B %d, %Y") %></span>.
          </p>
          <div class="flex flex-wrap gap-2">
            <%= for alert <- @alerts do %>
              <div class="w-full border border-gray-400 rounded-md shadow-sm p-2">
                <p><%= alert.title %></p>
                <p>Affecting these routes: <%= Enum.join(alert.routes, ", ") %></p>
              </div>
            <% end %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
