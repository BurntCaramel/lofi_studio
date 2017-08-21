defmodule LofiPlayWeb.ComponentView do
  use LofiPlayWeb, :view
  import LofiPlayWeb.LayoutHelpers

  def display_component_type(type) do
    case type do
      1 -> "SVG"
      2 -> "HTML"
      3 -> "Primitives"
      _ -> "Unknown"
    end
  end
end
