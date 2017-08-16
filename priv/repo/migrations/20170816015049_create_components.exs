defmodule LofiPlay.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components) do
      add :name, :string
      add :type, :integer
      add :body, :text
      add :tags, :string

      timestamps()
    end

    create unique_index(:components, [:tags])

  end
end
