defmodule Blog.Post do
  use Blog.Web, :model

  schema "miniblog_posts" do
    belongs_to :category, Blog.Category

    field :title, :string
    field :body, :string
    field :permalink, :string
    field :published_at, Ecto.DateTime
    field :author_id, :integer
    field :state, :string
    field :publisher_id, :integer
    field :ready_for_review, :boolean
    field :marked_for_review_at, :datetime
    field :cms, :boolean, default: false

    timestamps
  end

  def post_query do
    from p in Blog.Post,
      select: p,
      left_join: c in assoc(p, :category),
      preload: [category: c],
      order_by: [ desc: p.published_at ]
  end

  def public_post(query) do
    from p in query,
      where: not p.cms and p.state == "published"
  end

  def static_post(query) do
    from p in query,
      where: p.cms and p.state == "published"
  end

  def featured do
    query = from p in post_query,
      limit: 1

    query |> public_post |> Blog.Repo.one
  end

  def more_to_read_past(current_post) do
    query = from p in post_query,
      offset: 1,
      limit: 3,
      where: p.published_at < ^current_post.published_at

    query |> public_post|> Blog.Repo.all
  end

  def more_to_read_future(current_post) do
    query = from p in post_query,
      limit: 3,
      where: p.published_at > ^current_post.published_at

    query |> public_post |> Blog.Repo.all
  end

  def static_page(link) do
    query = from p in post_query,
      where: p.permalink == ^link

    query |> static_post |> Blog.Repo.one
  end

  def archive_posts do
    post_query |> public_post |> Blog.Repo.all
  end

  def admin_posts do
    from p in Blog.Post,
      order_by: [ asc: p.state, desc: p.published_at, desc: p.id ]
  end

  def published?(post) do
    post.state == "published"
  end

  def format_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Timex.Date.from(date)
    |> Timex.DateFormat.format!( "%B %e, %Y", :strftime)
  end

  def toggle_state(post) do
    if Blog.Post.published?(post) do
      %{ post | state: "drafted", published_at: nil }
    else
      %{ post | state: "published", published_at: Ecto.DateTime.local }
    end
  end

  @required_fields ~w(title category_id)
  @optional_fields ~w(body)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
