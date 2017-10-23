defmodule LofiPlayWeb.SearchController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Search

  def index(conn, %{"search" => search_params}) do
    changeset = %Search{}
    |> Search.changeset(search_params)

    screens = search_params["query"]
    |> Content.search_screens

    components = search_params["query"]
    |> Content.search_components

    render(conn, "index.html", search_changeset: changeset, screens: screens, components: components)
  end

  def index(conn, _params) do
    changeset = Search.changeset(%Search{}, %{})

    screens = []
    components = []

    render(conn, "index.html", search_changeset: changeset, screens: screens, components: components)
  end
end
