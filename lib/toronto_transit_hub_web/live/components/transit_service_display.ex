defmodule TorontoTransitHubWeb.Live.Components.TransitServiceDisplay do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div class={"p-2 rounded-md w-full bg-#{String.downcase(@service_name)}-500/25"}>
      <heading class="text-2xl italic font-semibold" id={"#{String.downcase(@service_name)}"}>
        <%= @service_name %>
      </heading>
      <div class="mt-4">
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
              <div class="w-full border border-slate-700 rounded-md shadow-sm p-2">
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
