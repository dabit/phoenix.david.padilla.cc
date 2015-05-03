defmodule Blog.PostsView do
  use Blog.Web, :view

  def show_post_path(conn, post) do
    posts_path(conn, :show, Blog.Post.permalink(post))
  end
end

