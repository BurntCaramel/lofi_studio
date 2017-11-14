defmodule LofiPlay.Preview.Components do
  alias LofiPlay.Preview
  alias Phoenix.HTML

  defp replace_key(body, key, replacement) do
    regex = "{{[\s]*#{Regex.escape(key)}[\s]*}}" |> Regex.compile!
    Regex.replace(regex, body, replacement)
    # String.replace(body, "@#{key}", replacement)
  end

  defp replace_html_for_ingredient_info(ingredient_info, html, %Lofi.Element{tags: tags, texts: texts}) do
    case ingredient_info do
      {:ok, {key, {_type, default, _choices}}} ->
        replacement = case key do
          # @texts uses texts of element
          # TODO: rename to @content
          "texts" ->
            Enum.join(texts)
          "content" ->
            Enum.join(texts)
          # Otherwise look up tag
          _ ->
            Preview.Lofi.get_content_tag(tags, key, default)
        end
        replace_key(html, key, replacement)
      {:error, _} ->
        html
    end
  end

  defp replace_html_for_ingredient_info(ingredient_info, html, values) do
    case ingredient_info do
      {:ok, {key, {_type, default, choices}}} ->
        replacement = Map.get(values, key)
        
        if is_nil(replacement) do
          html
        else
          replace_key(html, key, replacement)
        end
      {:error, _} ->
        html
    end
  end

  defp replace_html_for_ingredient_info(ingredient_info, html) do
    case ingredient_info do
      {:ok, {key, {_type, default, choices}}} ->
        replacement = if Enum.empty?(choices) do
          default
        else
          Enum.random(choices).texts
          |> Enum.join
        end
  
        if is_nil(replacement) do
          html
        else
          replace_key(html, key, replacement)
        end
      {:error, _} ->
        html
    end
  end

  def render_html_component(body, ingredients, lofi_element) do
    ingredients
    |> Preview.Lofi.parse_ingredients
    |> Enum.reduce(body, &replace_html_for_ingredient_info(&1, &2, lofi_element))
    |> HTML.raw
  end

  def render_html_component_preview(body, ingredients, values) do
    ingredients
    |> Preview.Lofi.parse_ingredients
    |> Enum.reduce(body, &replace_html_for_ingredient_info(&1, &2, values))
    |> HTML.raw
  end

  def render_html_component_preview(body, ingredients) do
    ingredients
    |> Preview.Lofi.parse_ingredients
    |> Enum.reduce(body, &replace_html_for_ingredient_info/2)
    |> HTML.raw
  end

  def render_lofi_component(body, ingredients_s, values) do
    # ingredient_infos = Preview.Lofi.parse_ingredients(ingredients_s)

    Preview.Bootstrap.preview_text(body, ingredients_s)
  end

  def render_lofi_component(body, ingredients_s) do
    # ingredient_infos = Preview.Lofi.parse_ingredients(ingredients_s)

    Preview.Bootstrap.preview_text(body, ingredients_s)
  end
end