defmodule LofiPlayWeb.PageController do
  use LofiPlayWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
