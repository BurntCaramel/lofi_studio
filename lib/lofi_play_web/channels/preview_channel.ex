defmodule LofiPlayWeb.PreviewChannel do
  use Phoenix.Channel
  alias LofiPlay.Content
  alias LofiPlay.Preview.Bootstrap
  alias Phoenix.HTML

  def join("lofi-preview", _message, socket) do
    {:ok, socket}
  end

  def handle_in("preview", %{"body" => body}, socket) do
    components = Content.list_components() # TODO: cache

    html = body
    |> Bootstrap.preview_text(components)
    |> Enum.map(&HTML.safe_to_string/1)
    |> Enum.join

    msg = %{"html" => html}
    {:reply, {:ok, msg}, socket}
  end

  def handle_in("component:preview:" <> component_id, %{"values" => values}, socket) do
    component = LofiPlay.Content.get_component!(component_id)
    body = component.body
    html = component
    |> LofiPlayWeb.ComponentView.preview(values)
    |> HTML.safe_to_string

    msg = %{"html" => html, "body" => body}
    {:reply, {:ok, msg}, socket}
  end
end