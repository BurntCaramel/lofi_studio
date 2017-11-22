defmodule LofiPlayWeb.AddController do
  use LofiPlayWeb, :controller

  @doc """
  Add a new item
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
