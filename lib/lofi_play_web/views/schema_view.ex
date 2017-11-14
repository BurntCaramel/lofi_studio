defmodule LofiPlayWeb.SchemaView do
  use LofiPlayWeb, :view
  alias LofiPlay.Preview

  def preview_body_form(body) do
    Preview.Bootstrap.preview_text(body, "")
  end

  def preview_body_faker(body) do
    Preview.Faker.preview_text(body)
  end

  def render("title.html", _assigns) do
    "Schemas · Lofi Studio"
  end

  def lofi_tree(lofi_text) do
    content_tag(:pre,
      lofi_text
      |> Preview.Tree.lofi_text
    )
  end
end
