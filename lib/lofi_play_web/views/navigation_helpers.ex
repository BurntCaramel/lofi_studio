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
        text_input(f, :query, placeholder: "Search Collected", aria: [label: "Search Collected"], class: "form-control")
      end
    end
end