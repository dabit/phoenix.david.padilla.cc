defmodule Blog.ArchiveController do
  use Blog.Web, :controller

  def index(conn, _) do
    posts = Blog.Post.archive_posts

    render conn, "index.html", posts: posts
  end
end
