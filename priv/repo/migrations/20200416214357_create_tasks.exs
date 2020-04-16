defmodule MyApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :varchar, size: 100, null: false
      add :description, :varchar, size: 600
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:tasks, [:name])
  end
end
