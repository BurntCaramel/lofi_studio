defmodule LofiPlayWeb.SchemaView do
  use LofiPlayWeb, :view
  import LofiPlayWeb.LayoutHelpers
  alias LofiPlay.Preview.Bootstrap

  def preview_body(body) do
    Bootstrap.preview_text(body)
  end
end
