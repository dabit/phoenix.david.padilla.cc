defmodule Blog.Admin.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _) do
    conn = put_layout conn, { Blog.Admin.LayoutView, "admin.html" }
    posts = Repo.all Blog.Post
    render conn, "index.html", posts: posts
  end
end
