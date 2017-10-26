defmodule LofiPlayWeb.SearchView do
  use LofiPlayWeb, :view

  def render("title.html", %{search_changeset: search_changeset}) do
    query = search_changeset.changes[:query]
    "Search “#{query}” · Lofi Studio"
  end

  def render("title.html", _assigns) do
    "Search · Lofi Studio"
  end
end
