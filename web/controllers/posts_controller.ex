defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    post = Blog.Post.featured
    more = Blog.Post.more_to_read

    render conn, "index.html", post: post, more: more
  end

  def show(conn, %{"id" => id}) do
    text conn, "something"
  end
end
