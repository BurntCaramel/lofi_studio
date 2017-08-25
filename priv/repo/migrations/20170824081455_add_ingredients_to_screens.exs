defmodule LofiPlay.Repo.Migrations.AddIngredientsToScreens do
  use Ecto.Migration

  def change do
    alter table(:screens) do
      add :ingredients, :text
    end
  end
end
