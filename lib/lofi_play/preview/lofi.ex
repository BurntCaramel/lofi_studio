defmodule LofiPlay.Preview.Lofi do
  def preview_tags_path(tags_path) do
    tags_path
    |> Enum.map_join(" ", &("#" <> &1))
  end

  def get_content_tag(tags_hash, name, default \\ nil) do
    case tags_hash do
      %{^name => {:content, %{texts: texts}}} ->
        Enum.join(texts, "")
      _ ->
        default
    end
  end

  def fetch_content_tag(tags_hash, name) do
    case tags_hash do
      %{^name => {:content, %{texts: texts}}} ->
        {:ok, Enum.join(texts, "")}
      %{^name => _value} ->
        {:error, :not_content}
      _ ->
        {:error, :missing}
    end
  end

  defp parse_ingredient_into_pair(%Lofi.Element{introducing: nil}), do: {:error, :missing_introducing}

  defp parse_ingredient_into_pair(%Lofi.Element{introducing: introducing, tags_hash: tags_hash, children: children}) when is_binary(introducing) do
    info = case tags_hash do
      %{"number" => {:flag, true}} ->
        default = get_content_tag(tags_hash, "default", get_content_tag(tags_hash, "min", "0"))
        {:number, default, children}
      %{"choice" => {:flag, true}} ->
        default = get_content_tag(tags_hash, "default")
        {:choice, default, children}
      _ ->
        default = get_content_tag(tags_hash, "default")
        {:text, default, children}
    end
    {:ok, {introducing, info}}
  end

  def parse_ingredients(text) do
    Lofi.Parse.parse_section(text)
    |> Enum.map(&parse_ingredient_into_pair/1)
    #|> Enum.into(%{})
  end

  defp transform_introductions_for_element(element) do
    element
    |> Map.put("texts", [element.introducing])
  end

  defp transform_introductions_for_elements(elements) do
    elements
    |> Enum.map(&transform_introductions_for_element/1)
  end

  def transform_introductions_to_text(sections) do
    sections
    |> Enum.map(&transform_introductions_for_elements/1)
  end

  def preview_with(prefix, resolver) do
    
  end
end