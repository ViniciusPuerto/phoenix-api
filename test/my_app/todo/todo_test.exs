defmodule MyApp.TodoTest do
  use MyApp.DataCase

  alias MyApp.Todo

  describe "tasks" do
    alias MyApp.Todo.Task

    @valid_attrs %{completed: true, description: "some description", name: "some name"}
    @update_attrs %{completed: false, description: "some updated description", name: "some updated name"}
    @invalid_attrs %{completed: nil, description: nil, name: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.name == "some name"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Todo.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.name == "some updated name"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end

    test "create_task/1 with name should be at most 100 characters returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(%{@valid_attrs | name: String.duplicate("a", 101)})
    end
    
    test "create_task/1 with description should be at most 600 characters returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(%{@valid_attrs | description: String.duplicate("a", 601)})
    end

    test "description is not required" do
      changeset = Task.changeset(%Task{}, Map.delete(@valid_attrs, :description))
      assert changeset.valid?
    end
  end
end
