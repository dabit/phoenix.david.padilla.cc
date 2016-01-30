defmodule Blog.Admin.SessionsController do
  use Blog.Web, :controller

  plug :put_layout, "admin.html"

  def new(conn, _) do
    changeset = Blog.User.changeset(%Blog.User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => session}) do
    changeset = Blog.User.changeset %Blog.User{}, session
    if user = Blog.User.authenticate?(changeset) do
      conn
        |> put_session(:user_id, user.id)
        |> redirect(to: admin_posts_path(conn, :index))
    end
    render conn, "new.html", changeset: changeset
  end

  def delete(conn, _) do
    conn
      |> put_session(:user_id, nil)
      |> redirect(to: admin_sessions_path(conn, :new))
  end
end
