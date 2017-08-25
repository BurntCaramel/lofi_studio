defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias LofiPlayWeb.IngredientsHelpers
  alias LofiPlay.Preview.Bootstrap
  
  def preview(screen, components: components, values: values) do
    Bootstrap.preview_text(screen.body, screen.ingredients || "", components, values)
  end

  def preview(screen, components: components) do
    Bootstrap.preview_text(screen.body, screen.ingredients || "", components)
  end

  def preview_in_iframe(conn, screen, layout) do
    content_tag(:iframe, '', class: "screen-preview-iframe", src: screen_preview_path(conn, :show, screen, layout: layout))
  end

  def ingredients_preview_form(conn, screen) do
    IngredientsHelpers.ingredients_preview_form(conn, screen.ingredients, [type: "screen", item_id: screen.id])
  end
end
