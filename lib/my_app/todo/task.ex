defmodule MyApp.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :description, :completed])
    |> unique_constraint(:name)
  end
end
