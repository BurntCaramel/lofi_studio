defmodule LofiPlay.Repo.Migrations.CreateScreens do
  use Ecto.Migration

  def change do
    create table(:screens) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
