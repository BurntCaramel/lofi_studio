defmodule LofiPlayWeb.ComponentView do
  use LofiPlayWeb, :view
  use Phoenix.HTML
  alias LofiPlayWeb.ElementHelpers
  alias LofiPlay.Preview

  def display_component_type(type) do
    case type do
      1 -> "SVG"
      2 -> "HTML"
      3 -> "Primitives"
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

  def ingredients_preview_form_item({key, {type, default, choices}}) do
    value = if Enum.empty?(choices) do
      default
    else
      Enum.random(choices).texts
      |> Enum.join
    end

    input_type = case type do
      :text -> "text"
      :number -> "number"
    end

    ElementHelpers.input(input_type, key, value: value, name: key)
  end

  def ingredients_preview_form(conn, component) do
    form_tag("", method: "get", id: "ingredients-preview-form", data: [type: "component", component_id: component.id]) do
      (component.ingredients || "")
      |> Preview.Lofi.parse_ingredients
      |> Enum.map(&ingredients_preview_form_item/1)
    end

    # ingredients = component.ingredients
    # |> Preview.Lofi.parse_ingredients

    # form_for conn, :show, [as: :previewed_ingredients, method: "get"], fn(f) ->
    #   ingredients
    #   |> Enum.map(&ingredients_preview_form_item(&1, f))
    # end
  end
end
