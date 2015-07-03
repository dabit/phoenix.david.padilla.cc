defmodule Blog.AboutMeController do
  use Blog.Web, :controller

  def show(conn, _) do
    post = Blog.Post.static_page("about-me")

    render conn, Blog.PostsView, "post.html", post: post
  end
end
