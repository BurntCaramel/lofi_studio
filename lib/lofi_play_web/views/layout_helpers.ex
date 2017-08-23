defmodule LofiPlayWeb.LayoutHelpers do

  @moduledoc """
  Conveniences for layouts.
  """

  use Phoenix.HTML

  @doc """
  Make a div.container-fluid
  """
  def container([do: block]) do
    content_tag(:div, block, class: "container-fluid")
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

    content_tag(:div, block, class: class)
  end

  @doc """
  Make a div.card
  """
  def card([do: block]) do
    content_tag(:div, [
      content_tag(:div, block, class: "card-body")
    ], class: "card")
  end

  @doc """
  Make a div.card
  """
  def card(opts, [do: block]) do
    header = Keyword.get(opts, :header)

    content_tag(:div, [
      content_tag(:div, header, class: "card-header"),
      content_tag(:div, block, class: "card-body p-0")
    ], class: "card")
  end
end
