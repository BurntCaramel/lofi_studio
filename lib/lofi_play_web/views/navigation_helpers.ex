defmodule LofiPlayWeb.NavigationHelpers do
  @moduledoc """
  Conveniences for navigation & search.
  """

  use Phoenix.HTML
  import LofiPlayWeb.Router.Helpers
  alias LofiPlay.Content.Search

  
  def search_form(conn) do
    changeset = Map.get(conn.assigns, :search_changeset, Search.changeset(%Search{}, %{}))

    form_for changeset, search_path(conn, :index), [method: "get"], fn f ->
      text_input(f, :query, placeholder: "Search", aria: [label: "Search Collected"], class: "form-control")
    end
  end

  def nav_link(text, opts) do
    link_class = case Keyword.get(opts, :class) do
      nil -> "nav-link"
      class -> "#{class} nav-link"
    end

    content_tag(:li, [
      link(text, Keyword.put(opts, :class, link_class))
    ], class: "nav-item")
  end
end