defmodule LofiPlayWeb.API.SchemaController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Schema

  def index(conn, _params) do
    schemas = Content.list_schemas()
    json(conn, schemas)
  end

  def show(conn, %{"id" => id}) do
    schema = Content.get_schema!(id)
    json(conn, schema)
  end
end

defmodule LofiPlayWeb.API.SchemaFakerController do
  use LofiPlayWeb, :controller

  alias LofiPlay.Content
  alias LofiPlay.Content.Schema
  alias LofiPlay.Preview

  def index(conn, _params) do
    schemas = Content.list_schemas()
    json(conn, schemas)
  end

  def show(conn, %{"schema_id" => id}) do
    schema = Content.get_schema!(id)
    json(conn, Preview.Faker.json_for_text(schema.body))
  end
end
