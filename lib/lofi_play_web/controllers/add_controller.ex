defmodule LofiPlayWeb.AddController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content

  defp changeset_for(%{ "type" => "screen" }) do
    changeset = Content.change_screen(%Content.Screen{})
  end

  defp changeset_for(%{ "type" => "component" }) do
    changeset = Content.change_component(%Content.Component{})
  end

  defp changeset_for(%{ "type" => "schema" }) do
    changeset = Content.change_schema(%Content.Schema{})
  end

  defp changeset_for(_params) do
    changeset = Content.change_journey(%Content.Journey{})
  end

  @doc """
  Add a new item
  """
  def index(conn, params) do
    changeset = changeset_for(params)
    type = Map.get(params, "type", "journey")
    render(conn, "index.html", type: type, changeset: changeset)
  end
end
