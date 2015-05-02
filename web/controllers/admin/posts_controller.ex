defmodule Blog.Admin.PostsController do
  use Blog.Web, :controller

  plug :authenticate
  plug :put_layout, "admin.html"
  plug :action

  def authenticate(conn, _) do
    user_id = get_session(conn, :user_id)
    if user_id do
      conn
    else
      redirect(conn, to: admin_sessions_path(conn, :new))
    end
  end

  def new(conn, _) do
    changeset = Blog.Post.changeset(%Blog.Post{})
    categories = Blog.Category.options_for_select
    render conn, "new.html", changeset: changeset, categories: categories
  end

  def create(conn, %{"post" => post}) do
    Blog.Post.changeset(%Blog.Post{state: "draft"}, post)
      |> Repo.insert

    conn
      |> put_flash(:notice, "Post created succesfully")
      |> redirect(to: admin_posts_path(conn, :index))
  end

  def index(conn, _) do
    posts = Repo.all Blog.Post.admin_posts
    render conn, "index.html", posts: posts
  end

  def edit(conn, %{"id" => id}) do
    changeset = Repo.get(Blog.Post, id)
            |> Blog.Repo.preload(:category)
            |> Blog.Post.changeset

    categories = Blog.Category.options_for_select
    render conn, "edit.html", changeset: changeset, categories: categories
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get(Blog.Post, id)
    changeset = Blog.Post.changeset(post, post_params)

    Repo.update changeset

    categories = Blog.Category.options_for_select

    conn
      |> put_flash(:notice, "Post updated succesfully")
      |> render("edit.html", changeset: changeset, categories: categories)
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get(Blog.Post, id)
    Repo.delete(post)

    conn
      |> put_flash(:notice, "Post deleted succesfully")
      |> redirect(to: admin_posts_path(conn, :index))
  end
end
