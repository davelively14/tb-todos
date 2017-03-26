defmodule Todos.TodoControllerTest do
  use Todos.ConnCase
  alias Todos.{Todo, Repo}

  describe "GET index" do
    test "renders a list with a single todo" do
      # Builds a new connection
      conn = build_conn()

      # Creates a new todo in the database via ExMachina. This will call the
      # todo function.
      todo = insert(:todo)

      conn = get conn, todo_path(conn, :index)

      assert json_response(conn, 200) == render_json("index.json", todos: [todo])
    end

    test "renders a list of all the todos" do
      conn = build_conn()
      for _ <- 1..10 do insert(:todo) end

      todos = Todo |> Repo.all

      conn = get conn, todo_path(conn, :index)
      assert json_response(conn, 200) == render_json("index.json", todos: todos)
    end
  end

  describe "GET show" do
    test "renders a single todo" do
      conn = build_conn()
      todo = insert(:todo)

      conn = get conn, todo_path(conn, :show, todo.id)

      assert json_response(conn, 200) == render_json("show.json", todo: todo)
    end
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    Todos.TodoView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
