defmodule LofiPlay.Repo.Migrations.AddDescriptionIngredientsToComponents do
  use Ecto.Migration

  def change do
    alter table(:components) do
      add :description, :text
      add :ingredients, :string
    end
  end
end
