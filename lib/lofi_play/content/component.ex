defmodule LofiPlay.Content.Component do
  use Ecto.Schema
  import Ecto.Changeset
  alias LofiPlay.Content.Component

  defmodule Type do
    def to_atom(type_i) do
      case type_i do
        1 -> :svg
        2 -> :html
        3 -> :lofi
        _ -> nil
      end
    end

    def display(type) do
      case type do
        1 -> "SVG"
        2 -> "HTML"
        3 -> "Lofi"
        _ -> nil
      end
    end
  end

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
