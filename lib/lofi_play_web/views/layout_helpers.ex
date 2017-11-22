defmodule LofiPlayWeb.LayoutHelpers do

  @moduledoc """
  Conveniences for layouts.
  """

  use Phoenix.HTML

  @doc """
  Make a div.container-fluid
  """
  def container([do: block]) do
    content_tag(:div, block, class: "container")
  end

  @doc """
  Make a div.container-fluid
  """
  def container(opts, [do: block]) do
    # Margins
    mt = Keyword.get(opts, :mt, 0)
    mb = Keyword.get(opts, :mb, 0)

    class = [
      "container",
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

  @doc """
  Save / cancel buttons for forms
  """
  def save_cancel(opts) do
    cancel_url = Keyword.get(opts, :cancel_url)

    changeset = Keyword.get(opts, :changeset)
    persisted = case changeset do
      nil -> false
      changeset -> Ecto.get_meta(changeset.data, :state) == :loaded
    end
    submit_title = case persisted do
      false -> "Create"
      true -> "Update"
    end

    content_tag(:div, [
      submit(submit_title, class: "btn btn-primary"),
      " ",
      if cancel_url do
        link("Cancel", to: cancel_url, class: "btn btn-secondary")
      else
        ""
      end
    ], class: "form-group")
  end
end
