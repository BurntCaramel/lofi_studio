defmodule LofiPlayWeb.ComponentView do
  use LofiPlayWeb, :view
  use Phoenix.HTML
  alias LofiPlayWeb.ElementHelpers
  alias LofiPlayWeb.IngredientsHelpers
  alias LofiPlay.Preview
  alias LofiPlay.Content.Component

  def display_component_type(type) do
    Component.Type.display(type) || "Unknown"
  end

  def preview(component, values) do
    ingredients = component.ingredients || ""
    type = component.type |> Component.Type.to_atom
    case type do
      :lofi -> Preview.Components.render_lofi_component(component.body, ingredients, values)
      _ -> Preview.Components.render_html_component_preview(component.body, ingredients, values)
    end
  end

  def preview(component) do
    ingredients = component.ingredients || ""
    type = component.type |> Component.Type.to_atom
    case type do
      :lofi -> Preview.Components.render_lofi_component(component.body, ingredients)
      _ -> Preview.Components.render_html_component_preview(component.body, ingredients)
    end
  end

  def ingredients_preview_form(conn, component) do
    IngredientsHelpers.ingredients_preview_form(conn, component.ingredients, [type: "component", item_id: component.id])
  end
end
