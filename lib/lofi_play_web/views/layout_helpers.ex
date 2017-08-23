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

  @doc """
  Make a div.container-fluid
  """
  def container(opts, [do: block]) do
    # Margins
    mt = Keyword.get(opts, :mt, 0)
    mb = Keyword.get(opts, :mb, 0)

    class = [
      "container-fluid",
      "mt-#{mt}",
      "mb-#{mb}"
    ] |> Enum.join(" ")

    Tag.content_tag(:div, block, class: class)
  end
end
