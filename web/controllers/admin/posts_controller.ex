defmodule Blog.Admin.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _) do
    conn = put_layout conn, { Blog.Admin.LayoutView, "admin.html" }
    posts = Repo.all Blog.Post
    render conn, "index.html", posts: posts
  end

  def edit(conn, %{"id" => id}) do
    changeset = Repo.get(Blog.Post, id)
            |> Blog.Post.changeset
    conn = put_layout conn, { Blog.Admin.LayoutView, "admin.html" }
    render conn, "edit.html", changeset: changeset
  end

  def update(conn, %{"id" => id, "post" => post}) do
    changeset = Repo.get(Blog.Post, id)
            |> Blog.Post.changeset(post)

    Repo.update changeset

    conn = put_layout conn, { Blog.Admin.LayoutView, "admin.html" }

    render conn, "edit.html", changeset: changeset
  end
end
