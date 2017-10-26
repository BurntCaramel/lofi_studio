defmodule LofiPlayWeb.NavigationHelpers do
  @moduledoc """
  Conveniences for navigation & search.
  """

  use Phoenix.HTML
  import LofiPlayWeb.Router.Helpers
  import LofiPlayWeb.ElementHelpers
  alias LofiPlay.Content.Search


  def search_form(form_data, path, opts) do
    label = Keyword.fetch!(opts, :label)

    form_for form_data, path, [method: "get", as: :search], fn f ->
      text_input(f, :q, name: "q", placeholder: label, aria: [label: label], class: "form-control")
    end
  end


  @search_label "Search Lofi Studio"
  
  def site_search_form(conn) do
    changeset = Map.get(conn.assigns, :search_changeset, Search.changeset(%Search{}, %{}))

    form_for changeset, search_path(conn, :index), [method: "get"], fn f ->
      text_input(f, :query, placeholder: @search_label, aria: [label: @search_label], class: "form-control")
    end
  end

  def nav_link(conn, text, opts) do
    to = Keyword.fetch!(opts, :to)
    current = if conn.query_string == "" do
      conn.request_path
    else
      "#{conn.request_path}?#{conn.query_string}"
    end
    active? = String.starts_with?(current, to)

    item_class = flatten_classes [
      {"nav-item", true},
      {"active", active?}
    ]

    link_class = flatten_classes [
      {"nav-link", true},
      {Keyword.get(opts, :class), Keyword.has_key?(opts, :class)}
    ]

    content_tag(:li, [
      link(text, Keyword.put(opts, :class, link_class))
    ], class: item_class)
  end

  def nav_link(text, opts) do
    link_class = flatten_classes [
      {"nav-link", true},
      {Keyword.get(opts, :class), Keyword.has_key?(opts, :class)}
    ]

    content_tag(:li, [
      link(text, Keyword.put(opts, :class, link_class))
    ], class: "nav-item")
  end
end