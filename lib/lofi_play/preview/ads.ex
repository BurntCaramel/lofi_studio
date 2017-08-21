defmodule LofiPlay.Preview.Ads do
  import LofiPlay.Preview.Lofi
  alias Phoenix.HTML
  alias Phoenix.HTML.Tag

  @headline_style [
    "font-size: 18px",
    "font-weight: normal",
    "color: #12c"
  ] |> Enum.join("; ")

  @doc """
  Headline #ad #
  """
  def preview(%Lofi.Element{tags: %{"ad" => {:flag, true}, "google" => {:flag, true}}}, %Lofi.Element{tags: tags, texts: texts}) do
    headline = Enum.join(texts)
    description = get_content_tag(tags, "description")
    Tag.content_tag(:div, [
      Tag.content_tag(:div, headline, class: "ad-headline", style: @headline_style),
      (unless is_nil(description), do: Tag.content_tag(:p, description), else: nil)
    ] |> Enum.reject(&is_nil/1))
  end

  def preview(_element, _element) do
    HTML.html_escape("")
  end
end