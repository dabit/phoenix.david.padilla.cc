defmodule Blog.PostsController do
  use Blog.Web, :controller

  plug :action

  def index(conn, _params) do
    post        = Blog.Post.featured
    more_past   = Blog.Post.more_to_read_past(post)
    more_future = Blog.Post.more_to_read_future(post)

    more = Enum.concat(more_future, more_past)

    render conn, "post.html", post: post, more: more, push_state: true
  end

  def show(conn, %{"id" => id}) do
    { post_id, _ } = Integer.parse(id)

    post = Repo.get(Blog.Post, post_id)
            |> Repo.preload(:category)

    more_past   = Blog.Post.more_to_read_past(post)
    more_future = Blog.Post.more_to_read_future(post)

    more = Enum.concat(more_past, more_future)

    render conn, "post.html", post: post, more: more
  end
end
