defmodule Todos.TodoControllerTest do
  use Todos.ConnCase
  alias Todos.{Repo, Todo}

  describe "GET index" do
    test "renders a list with a single todo" do
      # Builds a new connection
      conn = build_conn()

      # Creates a new todo in the database via ExMachina. This will call the
      # todo function.
      todo = insert(:todo)

      conn = get conn, todo_path(conn, :index)

      assert json_response(conn, 200) == %{
        "todos" => [%{
          "title" => todo.title,
          "description" => todo.description,
          "inserted_at" => todo.inserted_at |> NaiveDateTime.to_iso8601,
          "updated_at" => todo.updated_at |> NaiveDateTime.to_iso8601
        }]
      }
    end

    test "renders a list of all the todos" do
      conn = build_conn()
      for _ <- 1..10 do insert(:todo) end

      todos = Todo |> Repo.all |> Enum.map(&json_todo/1)

      conn = get conn, todo_path(conn, :index)
      assert json_response(conn, 200) == %{
        "todos" => todos
      }
    end
  end

  describe "GET show" do
    test "renders a single todo" do
      conn = build_conn()
      todo = insert(:todo)

      conn = get conn, todo_path(conn, :show, todo.id)

      assert json_response(conn, 200) == todo |> json_todo
    end
  end

  defp json_todo(todo) do
    %{
      "title" => todo.title,
      "description" => todo.description,
      "inserted_at" => todo.inserted_at |> NaiveDateTime.to_iso8601,
      "updated_at" => todo.updated_at |> NaiveDateTime.to_iso8601
    }
  end
end
