defmodule LofiPlayWeb.ComponentView do
  use LofiPlayWeb, :view
  #use LofiPlay.Preview.Components

  def display_component_type(type) do
    case type do
      1 -> "SVG"
      2 -> "HTML"
      3 -> "Primitives"
      _ -> "Unknown"
    end
  end

  def preview(component) do
    ingredients = component.ingredients || ""
    if is_nil(ingredients) do
      "No preview"
    else
      LofiPlay.Preview.Components.render_html_component_preview(component.body, ingredients)
    end
  end
end
