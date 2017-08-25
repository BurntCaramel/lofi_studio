defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias LofiPlayWeb.IngredientsHelpers
  alias LofiPlay.Preview.Bootstrap
  
  def preview_body(body, components: components) do
    Bootstrap.preview_text(body, components)
  end

  def preview_in_iframe(conn, screen, layout) do
    content_tag(:iframe, '', class: "screen-preview-iframe", src: screen_preview_path(conn, :show, screen, layout: layout))
  end

  def ingredients_preview_form(conn, screen) do
    IngredientsHelpers.ingredients_preview_form(conn, screen.ingredients, [type: "screen", item_id: screen.id])
  end
end
