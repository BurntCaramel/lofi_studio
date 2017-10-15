defmodule LofiPlay.Content.Journey do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Journey


  schema "journeys" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Journey{} = journey, attrs) do
    journey
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
