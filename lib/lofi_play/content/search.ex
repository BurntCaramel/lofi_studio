defmodule LofiPlay.Content.Search do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Search


  schema "search" do
    field :query, :string

    timestamps()
  end

  @doc false
  def changeset(%Search{} = search, attrs) do
    search
    |> cast(attrs, [:query])
    |> validate_required([:query])
  end
end
