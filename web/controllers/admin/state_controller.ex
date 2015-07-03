defmodule Blog.Admin.StateController do
  use Blog.Web, :controller

  def update(conn, %{"posts_id" => id}) do
    Repo.get(Blog.Post, id)
      |> Blog.Post.toggle_state
      |> Repo.update

    redirect(conn, to: admin_posts_path(conn, :index))
  end
end
