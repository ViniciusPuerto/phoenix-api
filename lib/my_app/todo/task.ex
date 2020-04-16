defmodule MyApp.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    timestamps(usec: false)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :completed])
    |> unique_constraint(:name)
    |> validate_length(:name, max: 100, count: :codepoints)
    |> validate_optional_string(:description, 600, "should be at most 600 characters.")
  end
  
  defp validate_optional_string(changeset, key, max, message) do
    field = get_field(changeset, key)
    cond do
      field == nil ->
        changeset
      get_codepoints_length(field) <= max ->
        changeset
      true ->
        add_error(changeset, key, message)
    end
  end

  defp get_codepoints_length(field) when is_bitstring(field) do
      field
      |> String.codepoints()
      |> length()
  end
end
