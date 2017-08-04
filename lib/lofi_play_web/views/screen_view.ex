defmodule LofiPlayWeb.ScreenView do
  use LofiPlayWeb, :view
  alias LofiPlay.Preview.Bootstrap
  
  def preview_body(body) do
    Bootstrap.preview_text(body)
  end
end
