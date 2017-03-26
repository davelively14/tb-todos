defmodule Todos.Factory do
  use ExMachina.Ecto, repo: Todos.Repo

  def todo_factory do
    %Todos.Todo{
      title: Faker.Name.title,
      description: Faker.Lorem.Shakespeare.as_you_like_it
    }
  end
end
