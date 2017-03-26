defmodule Todos.TodoController do
  use Todos.Web, :controller

  alias Todos.Todo

  def index(conn, _params) do
    todos = Todo |> Repo.all
    render conn, "index.json", todos: todos
  end

  def show(conn, %{"id" => id}) do
    todo = Todo |> Repo.get(id)
    render conn, "show.json", todo: todo
  end
end
