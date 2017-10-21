defmodule LofiPlayWeb.PreviewChannel do
  use Phoenix.Channel
  alias LofiPlay.Content
  alias LofiPlay.Preview.Bootstrap
  alias Phoenix.HTML

  def join("lofi-preview", _message, socket) do
    {:ok, socket}
  end

  # Previews Lofi with Bootstrap 4
  def handle_in("screen:preview", %{"body" => body}, socket) do
    components = Content.list_components() # TODO: cache

    html = body
    |> Bootstrap.preview_text("", components)
    |> Enum.map(&HTML.safe_to_string/1)
    |> Enum.join

    msg = %{"html" => html}
    {:reply, {:ok, msg}, socket}
  end

  # Previews Lofi with Bootstrap 4
  def handle_in("journey:preview", %{"body" => body}, socket) do
    screens = Content.list_screens() # TODO: cache

    html = body
    |> Bootstrap.preview_text("", screens)
    |> Enum.map(&HTML.safe_to_string/1)
    |> Enum.join

    msg = %{"html" => html}
    {:reply, {:ok, msg}, socket}
  end

  # Renders a saved component with supplied values
  def handle_in("component:preview:" <> component_id, %{"values" => values}, socket) do
    component = LofiPlay.Content.get_component!(component_id)
    html = component
    |> LofiPlayWeb.ComponentView.preview(values)
    |> HTML.safe_to_string

    msg = %{"html" => html, "body" => component.body}
    {:reply, {:ok, msg}, socket}
  end
end