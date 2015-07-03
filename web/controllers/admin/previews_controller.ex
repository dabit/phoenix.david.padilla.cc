defmodule Blog.Admin.PreviewsController do
  use Blog.Web, :controller

  plug :authenticate

  def authenticate(conn, _) do
    user_id = get_session(conn, :user_id)
    if user_id do
      conn
    else
      conn |> redirect(to: admin_sessions_path(conn, :new)) |> halt
    end
  end

  def show(conn, %{"posts_id" => id}) do
    post = Blog.Repo.get(Blog.Post, id)
            |> Blog.Repo.preload(:category)

    render conn, Blog.PostsView, "post.html", post: post, more: []
  end
end
