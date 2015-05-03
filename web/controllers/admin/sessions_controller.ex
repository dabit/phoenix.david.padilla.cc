defmodule Blog.Admin.SessionsController do
  use Blog.Web, :controller

  plug :put_layout, "admin.html"
  plug :action

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session}) do
    if user = Blog.User.authenticate?(session["email"], session["password"]) do
      conn
        |> put_session(:user_id, user.id)
        |> redirect(to: admin_posts_path(:index))
    end
    render conn, "new.html", session: session
  end

  def delete(conn, _) do
    conn
      |> put_session(:user_id, nil)
      |> redirect(to: admin_sessions_path(conn, :new))
  end
end
