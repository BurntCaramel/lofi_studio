defmodule LofiPlay.Repo.Migrations.CreateSchemas do
  use Ecto.Migration

  def change do
    create table(:schemas) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
