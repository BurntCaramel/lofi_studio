defmodule LofiPlay.Repo.Migrations.CreateJourneys do
  use Ecto.Migration

  def change do
    create table(:journeys) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
