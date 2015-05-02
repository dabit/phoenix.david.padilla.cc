defmodule Blog.Admin.PostsView do
  use Blog.Web, :view

  def edit_post_button(conn, post) do
    link("Edit", to: admin_posts_path(conn, :edit, post.id), class: "btn btn-default btn-block")
  end

  def publish_post_button(conn, post) do
    state_class = if Blog.Post.published?(post) do
      "btn-success"
    else
      "btn-danger"
    end
    link("Publish", to: admin_posts_state_path(conn, :update, post.id), class: "btn btn-default btn-block #{state_class}", method: :patch)
  end

  def delete_post_button(conn, post) do
    link("Delete", to: admin_posts_path(conn, :delete, post.id), class: "btn btn-default btn-block", method: :delete)
  end
end
