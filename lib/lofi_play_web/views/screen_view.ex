defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias LofiPlay.Preview.Bootstrap
  alias Phoenix.HTML.Tag
  
  def preview_body(body) do
    Bootstrap.preview_text(body)
  end

  def container([do: block]) do
    Tag.content_tag(:div, block, class: "container-fluid")
  end
end
