defmodule LofiPlay.Preview.Tree do
  use Phoenix.HTML

  def lofi_text(text) when is_binary(text) do
    Lofi.Parse.parse_sections(text)
    |> preview_sections
  end

  defp preview_sections(sections) do
    sections
    |> Enum.map(&preview_section/1)
  end

  defp preview_section(lines) do
    html_lines = Enum.map(lines, &lofi_element/1)

    content_tag(:div, html_lines, class: "mb-3")
  end

  defp preview_tags(tags) do
    tag_names = tags
    |> Map.keys
    |> Enum.join(" #")

    ["#" | tag_names]
  end

  defp preview_tags_and_text(tags, texts) do
    type = cond do
      Map.has_key?(tags, "screen") -> :screen
      Map.has_key?(tags, "message") -> :message
      Map.has_key?(tags, "promotion") -> :promotion
      true -> :unknown
    end

    {first, second} = if texts == [""] do
      case type do
        :screen ->
          {
            "#screen",
            preview_tags(Map.drop(tags, ["screen"]))
          }
        :message ->
          {
            "#message",
            preview_tags(Map.drop(tags, ["message"]))
          }
        :promotion ->
          {
            "#promotion",
            preview_tags(Map.drop(tags, ["promotion"]))
          }
        _ ->
          {
            preview_tags(tags),
            ""
          }
      end
    else
      {
        preview_tags(tags),
        Enum.join(texts)
      }
    end

    {type, first, second}
  end

  defp lofi_element(%Lofi.Element{introducing: introducing, texts: texts, tags: tags, children: children}) do
    {type, tags_preview, texts_preview} = preview_tags_and_text(tags, texts)

    class_name = case type do
      :screen -> "alert alert-primary"
      :message -> "alert alert-success"
      :promotion -> "alert alert-warning"
      #_ -> "alert alert-info"
      _ -> ""
    end

    content_tag(:div, [
      content_tag(:small, html_escape(tags_preview), class: "d-block font-weight-bold"),
      content_tag(:div, html_escape(texts_preview))
    ], class: class_name)
  end
end