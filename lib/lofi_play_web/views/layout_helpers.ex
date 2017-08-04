defmodule LofiPlayWeb.LayoutHelpers do

  @moduledoc """
  Conveniences for layouts.
  """

  alias Phoenix.HTML.Tag
  use Phoenix.HTML

  @doc """
  Make a div.container-fluid
  """
  def container([do: block]) do
    Tag.content_tag(:div, block, class: "container-fluid")
  end
end
