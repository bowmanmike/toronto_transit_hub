defmodule TorontoTransitHub.Alert do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id, :integer
    field :title, :string
    field :routes, :string
    field :route_order, :integer
    field :route_branch, :string
    field :description, :string
    field :effect, :string
    field :effect_description, :string
    field :severity_order, :integer
    field :severity, :string
    field :header_text, :string
  end

  def changeset(%__MODULE__{} = alert, attrs \\ %{}) do
    alert
    |> cast(attrs, __schema__(:fields))
    |> parse_routes()
    |> apply_action!(:insert)
  end

  defp parse_routes(%{changes: %{routes: routes}} = changeset) do
    parsed_routes = String.split(routes, ",")
    put_change(changeset, :routes, parsed_routes)
  end
end
