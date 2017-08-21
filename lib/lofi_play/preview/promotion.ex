defmodule LofiPlay.Preview.Promotion do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML
  alias Phoenix.HTML.Tag

  @headline_style [
    "font-size: 16px",
    "font-weight: normal",
    "color: #15c"
  ] |> Enum.join("; ")

  @description_style [
    "font-size: 14px",
  ] |> Enum.join("; ")

  @post_body_style [
    "font-size: 16px",
  ] |> Enum.join("; ")

  @doc """
  Headline #ad #google
  """
  # def preview([:ad, :google], %Lofi.Element{texts: texts, props: props}) do
  def preview(%Lofi.Element{tags: %{"ad" => {:flag, true}, "google" => {:flag, true}}}, %Lofi.Element{tags: tags, texts: texts}) do
    headline = Enum.join(texts)
    description = get_content_tag(tags, "description")
    Tag.content_tag(:div, [
      Tag.content_tag(:div, headline, class: "ad-headline", style: @headline_style),
      (unless is_nil(description), do: Tag.content_tag(:p, description, style: @description_style), else: nil)
    ] |> Enum.reject(&is_nil/1))
  end

  @doc """
  I am thoughtleadering like the boss of moss #post
  """
  def preview(%Lofi.Element{tags: %{"post" => {:flag, true}}}, %Lofi.Element{tags: tags, texts: texts}) do
    body = Enum.join(texts)
    name = get_content_tag(tags, "name")
    username = get_content_tag(tags, "username")
    Tag.content_tag(:div, [
      Tag.content_tag(:div, [
        (unless is_nil(name), do: Tag.content_tag(:strong, name, style: @post_body_style), else: nil),
        " ",
        (unless is_nil(username), do: Tag.content_tag(:span, "@#{username}", style: @post_body_style), else: nil),
        " · ",
        "16m"
      ] |> Enum.reject(&is_nil/1)),
      Tag.content_tag(:div, body, style: @post_body_style)
    ])
  end

  def preview(_element, _element) do
    nil
  end
end