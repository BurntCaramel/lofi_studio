defmodule LofiPlay.Preview.Lofi do
  def has_flag_tag(tags, name) do
    case tags do
      %{^name => {:flag, true}} -> true
      _ -> false
    end
  end

  def get_content_tag(tags, name, default \\ nil) do
    case tags do
      %{^name => {:content, %{texts: texts}}} ->
        Enum.join(texts, "")
      _ ->
        default
    end
  end

  def fetch_content_tag(tags, name) do
    case tags do
      %{^name => {:content, %{texts: texts}}} ->
        {:ok, Enum.join(texts, "")}
      %{^name => _value} ->
        {:error, :not_content}
      _ ->
        {:error, :missing}
    end
  end

  defp parse_ingredient_into_pair(%Lofi.Element{introducing: introducing, tags: tags}) do
    info = case tags do
      %{"number" => {:flag, true}} ->
        default_s = get_content_tag(tags, "default", get_content_tag(tags, "min", "0"))
        {:number, default_s}
      _ ->
        default_s = get_content_tag(tags, "default", "")
        {:text, default_s}
    end
    {introducing, info}
  end

  def parse_ingredients(text) do
    Lofi.Parse.parse_section(text)
    |> Enum.map(&parse_ingredient_into_pair/1)
    #|> Enum.into(%{})
  end
end