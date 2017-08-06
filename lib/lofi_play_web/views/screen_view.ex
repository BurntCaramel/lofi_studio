defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  import LofiPlayWeb.LayoutHelpers
  alias LofiPlay.Preview.Bootstrap
  
  def preview_body(body) do
    Bootstrap.preview_text(body)
  end

  def preview_in_iframe(conn, screen, layout) do
    content_tag(:iframe, '', class: "screen-preview-iframe", src: screen_preview_path(conn, :show, screen, layout: layout))
  end
end
