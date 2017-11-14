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

    content_tag(:div, html_lines, class: "row")
  end

  defp preview_tags(tags) do
    tag_names = tags
    |> Map.keys
    |> Enum.join(" #")

    case tag_names do
      "" -> ""
      s -> "#" <> s
    end
  end

  defp preview_tags_and_text(tags, texts, nil) do
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

  defp preview_tags_and_text(tags, texts, introducing) do
    {
      :introducing,
      preview_tags(tags),
      introducing <> ":"
    }
  end

  defp lofi_element(%Lofi.Element{introducing: introducing, texts: texts, tags: tags, children: children}, depth \\ 0) do
    {type, tags_preview, texts_preview} = preview_tags_and_text(tags, texts, introducing)

    el = case depth do
      0 -> :div
      _ -> :li
    end

    {outer_class, text_class} = case {type, depth} do
      {:screen, _} -> {"alert alert-primary", ""}
      {:message, _} -> {"alert alert-success", ""}
      {:promotion, _} -> {"alert alert-warning", ""}
      {:introducing, _} -> {"mb-3", "font-italic"}
      {_, 0} -> {"mb-3", ""}
      {_, _} -> {"", ""}
    end

    content_tag(el, [
      content_tag(:small, html_escape(tags_preview), class: "d-block font-weight-bold"),
      content_tag(:div, html_escape(texts_preview), class: text_class),
      case children do
        [] ->
          ""
        children ->
          content_tag(:ul, Enum.map(children, &lofi_element(&1, depth + 1)))
      end
    ], class: outer_class <> " col-12")
  end
end