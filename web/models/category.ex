defmodule Blog.Category do
  use Blog.Web, :model

  schema "categories" do
    field :name, :string

    has_many :posts, Blog.Post
  end

  def options_for_select do
    Blog.Repo.all(sorted)
      |> Enum.map(fn(c) -> [ "#{c.name}": c.id ] end)
      |> List.flatten
  end

  def sorted do
    from c in Blog.Category,
      order_by: [asc: c.name]
  end
end
