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

  defp lofi_element(%Lofi.Element{introducing: introducing, texts: texts, tags: tags, children: children}) do
    tag_names = tags
    |> Map.keys
    |> Enum.join(" #")

    content_tag(:div, [
      content_tag(:small, html_escape("##{tag_names}"), class: "d-block"),
      content_tag(:div, html_escape(texts |> Enum.join("")))
    ])
  end
end