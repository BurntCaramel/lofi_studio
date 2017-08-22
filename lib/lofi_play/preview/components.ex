defmodule LofiPlay.Preview.Components do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML

  def render_html_component(body, ingredients, %Lofi.Element{tags: tags, texts: texts}) do
    ingredient_infos = parse_ingredients(ingredients)

    adjusted = ingredient_infos
    |> Enum.reduce(body, fn({key, {_type, default, _choices}}, html) ->
      replacement = case key do
        # @texts uses texts of element
        "texts" ->
          Enum.join(texts)
        # Otherwise look up tag
        _ ->
          get_content_tag(tags, key, default)
      end
      String.replace(html, "@#{key}", replacement)
    end)

    HTML.raw(adjusted)
  end

  def render_html_component_preview(body, ingredients) do
    ingredient_infos = parse_ingredients(ingredients)

    adjusted = ingredient_infos
    |> Enum.reduce(body, fn({key, {_type, default, choices}}, html) ->
      replacement = if Enum.empty?(choices) do
        default
      else
        Enum.random(choices).texts
        |> Enum.join
      end

      if is_nil(replacement) do
        html
      else
        String.replace(html, "@#{key}", replacement)
      end
    end)

    HTML.raw(adjusted)
  end
end