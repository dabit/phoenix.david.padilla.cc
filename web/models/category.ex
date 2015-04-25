defmodule Blog.Category do
  use Blog.Web, :model

  schema "categories" do
    field :name, :string

    has_many :posts, Blog.Post
  end
end
