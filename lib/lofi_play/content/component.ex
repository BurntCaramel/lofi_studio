defmodule LofiPlay.Content.Component do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Component


  schema "components" do
    field :body, :string
    field :name, :string
    field :tags, :string
    field :type, :integer
    field :description, :string
    field :ingredients, :string

    timestamps()
  end

  @doc false
  def changeset(%Component{} = component, attrs) do
    component
    |> cast(attrs, [:name, :type, :body, :tags, :description, :ingredients])
    |> update_change(:tags, &String.trim/1) # Trim tags
    |> unique_constraint(:tags) # Tags are unique
    |> validate_required([:name, :type, :body, :tags])
  end
end
