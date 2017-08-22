defmodule LofiPlayWeb.PreviewChannel do
  use Phoenix.Channel
  alias LofiPlay.Preview.Bootstrap
  alias Phoenix.HTML

  def join("lofi-preview", _message, socket) do
    {:ok, socket}
  end

  def handle_in("preview", %{"body" => body}, socket) do
    html = body
    |> Bootstrap.preview_text
    |> Enum.map(&HTML.safe_to_string/1)
    |> Enum.join

    push socket, "previewed", %{"html" => html}
    #{:reply, :ok, socket}
    {:noreply, socket}
  end
end