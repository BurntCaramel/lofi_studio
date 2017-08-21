defmodule LofiPlay.Preview.Components do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML
  alias Phoenix.HTML.Tag

  def render_html_component(body, ingredients, %Lofi.Element{tags: tags, texts: texts}) do
    ingredient_infos = parse_ingredients(ingredients)

    adjusted = ingredient_infos
    |> Enum.reduce(body, fn({key, {_type, default}}, html) ->
      replacement = case key do
        "texts" ->
          Enum.join(texts)
        _ ->
          get_content_tag(tags, key, default)
      end
      String.replace(html, "@#{key}", replacement)
    end)

    HTML.raw(adjusted)
  end
end