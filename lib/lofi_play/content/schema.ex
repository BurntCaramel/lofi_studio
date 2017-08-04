defmodule LofiPlay.Content.Schema do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Schema


  schema "schemas" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Schema{} = schema, attrs) do
    schema
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
