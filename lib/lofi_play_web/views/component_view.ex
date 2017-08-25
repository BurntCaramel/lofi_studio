defmodule LofiPlayWeb.ComponentView do
  use LofiPlayWeb, :view
  use Phoenix.HTML
  alias LofiPlayWeb.ElementHelpers
  alias LofiPlayWeb.IngredientsHelpers
  alias LofiPlay.Preview

  def display_component_type(type) do
    case type do
      1 -> "SVG"
      2 -> "HTML"
      3 -> "Lofi"
      _ -> "Unknown"
    end
  end

  def preview(component, values) do
    ingredients = component.ingredients || ""
    if is_nil(ingredients) do
      "No preview"
    else
      Preview.Components.render_html_component_preview(component.body, ingredients, values)
    end
  end

  def preview(component) do
    ingredients = component.ingredients || ""
    if is_nil(ingredients) do
      "No preview"
    else
      Preview.Components.render_html_component_preview(component.body, ingredients)
    end
  end

  def ingredients_preview_form(conn, component) do
    IngredientsHelpers.ingredients_preview_form(conn, component.ingredients, [type: "component", item_id: component.id])
  end
end
