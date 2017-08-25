defmodule LofiPlayWeb.SchemaView do
  use LofiPlayWeb, :view
  alias LofiPlay.Preview.Bootstrap
  alias LofiPlay.Preview.Faker

  def preview_body_form(body) do
    Bootstrap.preview_text(body, "")
  end

  def preview_body_faker(body) do
    Faker.preview_text(body)
  end
end
