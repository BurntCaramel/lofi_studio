defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias LofiPlayWeb.IngredientsHelpers
  alias LofiPlay.Preview.Bootstrap
  alias LofiPlay.Preview
  
  # Preview with the supplied values
  def preview(screen, components: components, values: values) do
    Bootstrap.preview_text(screen.body, screen.ingredients || "", components, values)
  end

  # Preview with default/random values
  def preview(screen, components: components) do
    Bootstrap.preview_text(screen.body, screen.ingredients || "", components)
  end

  def preview_in_iframe(conn, screen, layout) do
    content_tag(:iframe, "", class: "screen-preview-iframe", src: screen_preview_path(conn, :show, screen, layout: layout))
  end

  def ingredients_preview_form(conn, screen) do
    IngredientsHelpers.ingredients_preview_form(conn, screen.ingredients, [type: "screen", item_id: screen.id])
  end

  def render("title.html", _assigns) do
    "Screens · Lofi Studio"
  end

  def lofi_tree(screen) do
    screen.body
    |> Preview.Tree.lofi_text
  end
end
