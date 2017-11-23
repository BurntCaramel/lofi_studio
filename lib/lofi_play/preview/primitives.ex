defmodule LofiPlay.Preview.Primitives do
  import LofiPlay.Preview.Lofi
  use Phoenix.HTML

  @doc """
  Textual description #image #source: https://via.placeholder.com/@widthx@height
  """
  def preview(%Lofi.Element{tags_hash: %{"image" => {:flag, true}, "source" => {:content, source_content}}}, %Lofi.Element{texts: texts, tags_hash: tags}, resolve_content) do
    source_url = resolve_content.(source_content.texts, source_content.mentions)
    description = Enum.join(texts)
    width = get_content_tag(tags, "width")
    height = get_content_tag(tags, "height")
    tag(:img, src: source_url, alt: description, width: width, height: height)
  end

  def preview(%Lofi.Element{tags_hash: %{"note" => {:flag, true}}}, %Lofi.Element{texts: texts, mentions: mentions}, resolve_content) do
    content_tag(:details, [
      content_tag(:summary, "Note"),
      content_tag(:span, resolve_content.(texts, mentions))
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
  def preview(%Lofi.Element{children: []}, %Lofi.Element{texts: texts, mentions: mentions, tags_hash: tags}, resolve_content) do
    tag = cond do
      Lofi.Tags.has_flag(tags, "primary") ->
        :h1
      Lofi.Tags.has_flag(tags, "secondary") ->
        :h2
      true ->
        :p
    end
    
    content_tag(tag, resolve_content.(texts, mentions))
  end

  def preview(_element1, _element2, _resolve_content) do
    nil
  end
end