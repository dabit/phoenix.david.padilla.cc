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
    link("Publish", to: admin_posts_state_path(conn, :show, post.id), class: "btn btn-default btn-block #{state_class}")
  end

  def delete_post_button(post) do
    link("Delete", to: "/", class: "btn btn-default btn-block")
  end
end
