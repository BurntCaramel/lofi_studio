defmodule LofiPlayWeb.API.ScreenController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Screen

  def index(conn, _params) do
    screens = Content.list_screens()
    json(conn, screens)
  end

  def show(conn, %{"id" => id}) do
    screen = Content.get_screen!(id)
    json(conn, screen)
  end
end
