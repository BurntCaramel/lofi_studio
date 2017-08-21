defmodule LofiPlay.Preview.Ads do
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

  def preview(_element, _element) do
    HTML.html_escape("")
  end
end