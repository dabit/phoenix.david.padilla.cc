defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    text conn, "should what"
  end

  def show(conn, %{"id" => id}) do
    text conn, "something"
  end
end
