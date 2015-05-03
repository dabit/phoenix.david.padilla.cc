defmodule Blog.SitemapController do
  use Blog.Web, :controller

  alias Blog.Post

  plug :accepts, ["xml"]
  plug :put_resp_content_type, "xml"
  plug :action


  def show(conn, _) do
    about = Blog.Post.static_page("about-me")
    posts = Post.archive_posts
    last_post = List.last(posts)

    render conn, "index.xml", posts: posts, last_post: last_post, about: about
  end
end
