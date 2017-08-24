defmodule LofiPlay.Preview.Primitives do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML
  alias Phoenix.HTML.Tag

  @doc """
  Textual description #image #source: https://via.placeholder.com/@widthx@height
  """
  def preview(%Lofi.Element{tags: %{"image" => {:flag, true}, "source" => {:content, source_content}}}, %Lofi.Element{texts: texts, tags: tags}) do
    source_url = Enum.join(source_content.texts)
    description = Enum.join(texts)
    width = get_content_tag(tags, "width")
    height = get_content_tag(tags, "height")
    Tag.tag(:img, src: source_url, alt: description, width: width, height: height)
  end

  def preview(%Lofi.Element{tags: %{"note" => {:flag, true}}}, %Lofi.Element{texts: texts}) do
    Tag.content_tag(:details, [
      Tag.content_tag(:summary, "Note"),
      Tag.content_tag(:span, Enum.join(texts))
    ])
  end

  @doc """
      Hello #primary
      <h1>Hello</h1>

      Hello #secondary
      <h2>Hello</h2>

      Hello
      <p>Hello</p>
  """
  def preview(%Lofi.Element{children: []}, %Lofi.Element{texts: texts, tags: tags}) do
    tag = cond do
      has_flag_tag(tags, "primary") ->
        :h1
      has_flag_tag(tags, "secondary") ->
        :h2
      true ->
        :p
    end
    
    Tag.content_tag(tag, Enum.join(texts))
  end

  def preview(_element, _element) do
    nil
  end
end