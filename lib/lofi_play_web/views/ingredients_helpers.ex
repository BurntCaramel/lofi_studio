defmodule LofiPlayWeb.IngredientsHelpers do
  use Phoenix.HTML
  alias LofiPlayWeb.ElementHelpers
  alias LofiPlay.Preview

  defp ingredients_preview_form_item({key, {type, default, choices}}) do
    value = if Enum.empty?(choices) do
      default
    else
      Enum.random(choices).texts
      |> Enum.join
    end

    label = key
    |> Phoenix.Naming.underscore
    |> Phoenix.Naming.humanize

    input_type = case type do
      :text -> ElementHelpers.input("text", label, value: value, name: key)
      :number -> ElementHelpers.input("number", label, value: value, name: key)
      :choice ->
        choices
        |> Enum.map(fn(%Lofi.Element{texts: texts}) -> Enum.join(texts) end)
        |> ElementHelpers.select(label, value: value, name: key)
    end
  end

  def ingredients_preview_form(conn, ingredients, data) do
    form_tag("", method: "get", id: "ingredients-preview-form", data: data) do
      (ingredients || "")
      |> Preview.Lofi.parse_ingredients
      |> Enum.map(&ingredients_preview_form_item/1)
    end
  end
end
