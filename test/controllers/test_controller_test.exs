defmodule Todos.TodoControllerTest do
  use Todos.ConnCase

  test "#index renders a list of todos" do
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
end
