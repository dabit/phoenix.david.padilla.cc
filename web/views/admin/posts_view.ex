defmodule Blog.Admin.PostsView do
  use Blog.Web, :view

  def edit_post_button(post) do
    link("Edit", to: "/", class: "btn btn-default btn-block")
  end

  def publish_post_button(post) do
    link("Publish", to: "/", class: "btn btn-default btn-block btn-danger")
  end

  def delete_post_button(post) do
    link("Delete", to: "/", class: "btn btn-default btn-block")
  end
end
