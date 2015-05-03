defmodule Blog.Admin.PostsController do
  use Blog.Web, :controller

  alias Blog.Post
  alias Blog.Category
  alias Blog.User

  plug :authenticate
  plug :put_layout, "admin.html"
  plug :scrub_params, "post" when action in [:create, :update]
  plug :action

  def authenticate(conn, _) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Repo.get User, user_id
      conn |> Map.put(:current_user, user)
    else
      conn |> redirect(to: admin_sessions_path(conn, :new)) |> halt
    end
  end

  def new(conn, _) do
    changeset  = Post.changeset(%Post{})
    categories = Category.options_for_select
    render conn, "new.html", changeset: changeset, categories: categories
  end

  def create(conn, %{"post" => post}) do
    Post.changeset(%Post{state: "draft", author_id: conn.current_user.id}, post)
      |> Repo.insert

    conn
      |> put_flash(:notice, "Post created succesfully")
      |> redirect(to: admin_posts_path(conn, :index))
  end

  def index(conn, _) do
    posts = Repo.all Post.admin_posts
    render conn, "index.html", posts: posts
  end

  def edit(conn, %{"id" => id}) do
    post      = Repo.get(Post, id)
    changeset = Repo.preload(post, :category)
      |> Post.changeset

    categories = Category.options_for_select
    render conn, "edit.html", changeset: changeset, post: post, categories: categories
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post      = Repo.get(Post, id)
    changeset = Post.changeset(post, post_params)

    Repo.update changeset

    categories = Category.options_for_select

    conn
      |> put_flash(:notice, "Post updated succesfully")
      |> render("edit.html", changeset: changeset, categories: categories, post: post)
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    Repo.delete(post)

    conn
      |> put_flash(:notice, "Post deleted succesfully")
      |> redirect(to: admin_posts_path(conn, :index))
  end
end
