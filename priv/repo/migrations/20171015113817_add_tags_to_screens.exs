defmodule LofiPlay.Repo.Migrations.AddTagsToScreens do
  use Ecto.Migration

  def change do
    alter table(:screens) do
      add :tags, :string
    end

    create unique_index(:screens, [:tags])
  end
end
