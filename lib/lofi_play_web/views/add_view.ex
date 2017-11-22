defmodule LofiPlayWeb.AddView do
  use LofiPlayWeb, :view
  use Phoenix.HTML

  def render_form(conn, %{ type: "journey" } = assigns) do
    render LofiPlayWeb.JourneyView, "form.html", Map.put(assigns, :action, journey_path(conn, :create))
  end

  def render_form(conn, %{ type: "screen" } = assigns) do
    render LofiPlayWeb.ScreenView, "form.html", Map.put(assigns, :action, screen_path(conn, :create))
  end

  def render_form(conn, %{ type: "component" } = assigns) do
    render LofiPlayWeb.ComponentView, "form.html", Map.put(assigns, :action, component_path(conn, :create))
  end

  def render_form(conn, %{ type: "schema" } = assigns) do
    render LofiPlayWeb.SchemaView, "form.html", Map.put(assigns, :action, schema_path(conn, :create))
  end
end
