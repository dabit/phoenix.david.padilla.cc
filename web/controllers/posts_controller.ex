defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    post = List.first(Blog.Post.featured)
    render conn, "index.html", post: post
  end

  def show(conn, %{"id" => id}) do
    text conn, "something"
  end
end
