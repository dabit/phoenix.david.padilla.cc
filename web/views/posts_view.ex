defmodule Blog.PostsView do
  use Blog.Web, :view

  def show_post_path(conn, post) do
    posts_path(conn, :show, "#{post.id}-#{post.permalink}")
  end
end

