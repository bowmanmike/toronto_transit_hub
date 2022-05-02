defmodule TorontoTransitHubWeb.PageController do
  use TorontoTransitHubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
