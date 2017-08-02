defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias Phoenix.HTML
  alias Phoenix.HTML.Tag

  @line_separators ~r/\r\n?|\n/
  @block_separators ~r/(\r\n?|\n){3,}/ # TODO? why 3, not 2,

  defp preview_line(line) do
    element = Lofi.Parse.parse_element(line)
    preview_line_element(element, element)
  end

  defp has_flag_tag(tags, name) do
    case tags do
      %{ ^name => {:flag, true} } -> true
      _ -> false
    end
  end

  defp flatten_classes(classes) do
    classes
    |> Enum.filter(&(Kernel.elem(&1, 1)))
    |> Enum.map(&(Kernel.elem(&1, 0)))
    |> Enum.join(" ")
  end

  defp preview_line_element(%Lofi.Element{ texts: texts, tags: %{ "button" => {:flag, true} } }, %Lofi.Element{ tags: tags }) do
    class = flatten_classes [
      {"btn", true},
      {"btn-primary", has_flag_tag(tags, "primary")}
    ]

    Tag.content_tag(:button, Enum.join(texts, ""), class: class)
  end

  defp preview_line_element(%Lofi.Element{ texts: texts, tags: %{ "primary" => {:flag, true} } }, element) do
    Tag.content_tag(:h1, Enum.join(texts, ""))
  end

  defp preview_line_element(%Lofi.Element{ texts: texts, tags: %{ "secondary" => {:flag, true} } }, element) do
    Tag.content_tag(:h2, Enum.join(texts, ""))
  end

  defp preview_line_element(%Lofi.Element{ texts: texts }, element) do
    Tag.content_tag(:p, Enum.join(texts, ""))
  end

  defp preview_block(block) do
    lines = String.split(block, "\n", trim: true)
    html_lines = Enum.map(lines, &preview_line/1)

    Tag.content_tag(:div, HTML.html_escape(html_lines))
  end

  def preview_body(body) do
    blocks = String.split(body, @block_separators, trim: true)

    Enum.map(blocks, &preview_block/1)
    #element = (body)
  end
end
