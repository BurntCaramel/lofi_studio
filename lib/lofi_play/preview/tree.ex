defmodule LofiPlay.Preview.Tree do
  use Phoenix.HTML
  alias LofiPlay.Preview

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

  defp preview_tags_path_and_text(tags_path, texts, nil) do
    [first_tag | rest_tags] = tags_path

    type = case first_tag do
      "screen" -> :screen
      "message" -> :message
      "promotion" -> :promotion
      _ -> :unknown
    end

    {first, second} = if texts == [""] do
      case type do
        :screen ->
          {
            "#screen",
            Preview.Lofi.preview_tags_path(rest_tags)
          }
        :message ->
          {
            "#message",
            Preview.Lofi.preview_tags_path(rest_tags)
          }
        :promotion ->
          {
            "#promotion",
            Preview.Lofi.preview_tags_path(rest_tags)
          }
        _ ->
          {
            Preview.Lofi.preview_tags_path(tags_path),
            ""
          }
      end
    else
      {
        Preview.Lofi.preview_tags_path(tags_path),
        Enum.join(texts)
      }
    end

    {type, first, second}
  end

  defp preview_tags_path_and_text(tags_path, texts, introducing) do
    {
      :introducing,
      Preview.Lofi.preview_tags_path(tags_path),
      introducing <> ":"
    }
  end

  defp lofi_element(%Lofi.Element{introducing: introducing, texts: texts, tags_path: tags_path, children: children}, depth \\ 0) do
    {type, tags_preview, texts_preview} = preview_tags_path_and_text(tags_path, texts, introducing)

    {col_class, outer_class, text_class} = case {type, depth} do
      {:screen, _} -> {"col-12", "alert alert-primary", ""}
      {:message, _} -> {"col-12", "alert alert-success", ""}
      {:promotion, _} -> {"col", "alert alert-warning col", ""}
      {:introducing, _} -> {"col-12", "mb-3", "font-weight-bold"}
      {_, 0} -> {"col-12", "mb-3", ""}
      {_, _} -> {"col-12", "", ""}
    end

    render = case depth do
      0 -> fn (elements) ->
          content_tag(:div, [
            content_tag(:div, elements, class: outer_class)
          ], class: col_class)
        end
      _ -> fn (elements) ->
          content_tag(:li, elements, class: outer_class)
        end
    end

    render.([
      content_tag(:small, html_escape(tags_preview), class: "d-block font-weight-bold font-italic"),
      content_tag(:div, html_escape(texts_preview), class: text_class),
      case children do
        [] ->
          ""
        children ->
          content_tag(:ul, Enum.map(children, &lofi_element(&1, depth + 1)))
      end
    ])
  end
end