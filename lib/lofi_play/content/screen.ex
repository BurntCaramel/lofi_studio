defmodule LofiPlay.Content.Screen do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Screen

  @derive {Poison.Encoder, only: [:id, :name, :body, :tags, :ingredients]}

  schema "screens" do
    field :body, :string
    field :name, :string
    field :tags, :string
    field :ingredients, :string

    timestamps()
  end

  @doc false
  def changeset(%Screen{} = screen, attrs) do
    screen
    |> cast(attrs, [:name, :body, :tags, :ingredients])
    |> validate_required([:name, :body])
  end
end
